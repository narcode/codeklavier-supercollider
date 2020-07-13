/*
addresses:
/cktree
/cktreeview
/cktreetransform (position, rotation, scale)
*/

s.waitForBoot{
	// ini vars:
	t = TempoClock.default.tempo_(70/60);
	~view = 1;
	h = Group.new(s);
	~path = thisProcess.nowExecutingPath.dirname ++ "/soundbanks/";
	// load soundbanks
	(
b = ();
~amps=();
~buses=();
~drones=();
~r_out=();
~delaywindow=();
~delayamps=();
~delaydecays=();
~reverb=();
~sub_division=[8, 4, 3, 2, 3/2, 1, 3/4, 0.5, 1/3, 1/4, 1/5];
~buses['rev'] = ();
		// ~buses['fx'] = ();
b[1] = ();	b[2] = ();	b[3] = ();	b[4] = (); b[5] = ();
9.do{|i|
	i = i+1;
	b[1][i] = Buffer.read(s, ~path ++ "808bd/" ++ i.asString ++ ".wav");
	b[2][i] = Buffer.read(s, ~path ++ "808hh/" ++ i.asString ++ ".wav");
	b[3][i] = Buffer.read(s, ~path ++ "808sd/" ++ i.asString ++ ".wav");
	b[4][i] = Buffer.read(s, ~path ++ "nasa/" ++ i.asString ++ "_mono.wav");
	b[5][i] = Buffer.read(s, ~path ++ "deep/" ++ i.asString ++ "_mono.wav");

			~buses[i] = Bus.audio(s, 2);
			~amps[i] = Synth(\busplay, [\bus, ~buses[i].index, \amp, 0.3]).register;
			~delayamps[i] = 0.2;
			~delaydecays[i] = 3;
			~buses['rev'][i] = Bus.audio(s, 2);
			// ~buses['fx'][i] = Bus.audio(s, 2);
			~reverb[i] = false;
			~delaywindow[i] = 0.2;
			~r_out[i] = 0;
		};
);

	s.sync;

// load synthdefs
(

SynthDef(\busplay, {arg out=0, bus=50, amp=1;
			var ins = In.ar(bus, 2);
			Out.ar(out, ins*amp);
}).store;

SynthDef(\busplay_reverb, {arg out=0, bus=50, amp=1, room=89, dec=8;
			var ins = GVerb.ar(In.ar(bus, 2), room, dec);
			Out.ar(out, ins*amp.lag(0.1));
}).store;

SynthDef(\bank1, {arg out=0, amp=1, rl=1, at=0.1, freq=123, eqfreq=789, ratio=1, rate=1;
	var in, fx, env;
	env = EnvGen.kr(Env.perc(at, rl), doneAction: 2);
	in = BrownNoise.ar(LFPulse.kr(ratio)*0.5);
	fx = BPF.ar(in, eqfreq, LFNoise0.kr(rate).range(0.01, 1));
	in = fx * env * amp;
	Out.ar(out, Pan2.ar(in, LFTri.kr(rate).range(-1, 1)));
}).store;

		// ~oct_gen = {|root, array|
		// 	array.add(root + 1);
		// 	array.add(root + 2);
		// 	if (array.size == 8) {
		// 		array;
		// 	} {
		// 		~oct_gen.value(root+2, array)
		// 	}
		// }
		//
		// ~oct_gen.value(21, []);

~oct_scale = [21, 21, 22, 24, 25, 27, 28, 30, 31, 33];

SynthDef(\bank_drone, {arg out=0, amp=1, rl=1, at=1, st=30, midinote=24, offset=0, ratio=1, rate=1, eqfreq=789, note=1, noise=1;
	var in, fx, env, in2, in3;
	in = BPF.ar(BrownNoise.ar(LFNoise0.kr(note).range(0, 0.05))*LFNoise2.kr(8).range(0.01, 1), LFTri.kr(note).range(50, 720), 0.2)*noise;
	in2 = SinOsc.ar([(midinote+offset).midicps, (midinote+offset+12).midicps], 0, 0.3) * 0.2;
	in3 = SinOsc.ar([(midinote+offset+(12*2)).midicps, (midinote+offset+12).midicps, (midinote+offset+3).midicps], 0, [1,0.3, 0.1]) * 0.2;
	env = EnvGen.kr(Env.linen(at, st, rl), doneAction: 2);
	in = (in * in2) + in2 + in3 + in;
	fx = HPF.ar(BPF.ar(in, eqfreq, LFNoise1.kr(rate).range(0.01, 1)), 30);
	in = fx * env * amp;
	Out.ar(out, Splay.ar(Limiter.ar(in.sum), 0.9));
}).store;

SynthDef(\bank3_fx, {arg out=0, in=0, amp=1, rl=99, at=0.1, pratio=1;
	var input, fx, env;
	env = EnvGen.kr(Env.linen(at, rl), doneAction: 2);
	input = SoundIn.ar(In.ar(in,2));
	fx = CombN.ar(PitchShift.ar(input, 0.2, [1/pratio, LFSaw.kr(1/pratio).range(0.25,1.5/pratio), 3/pratio, pratio/4]), 0.2, 3);
	input = fx * env * amp;
	Out.ar(out, Splay.ar(input));
}).store;

SynthDef(\bank_samples, {arg out=0, amp=1, rl=1, at=0.1, buffer=0, pos=0, rate=1;
	var in, fx, env;
	env = EnvGen.kr(Env.perc(at, rl), doneAction: 2);
			in = PlayBuf.ar(1, buffer, rate*BufRateScale.kr(buffer));
	in = in * env * amp;
	Out.ar(out, Pan2.ar(in, pos));
}).store;

SynthDef(\bank_samples_stereo, {arg out=0, amp=1, rl=1, at=0.0001, buffer=0, pos=0, rate=1;
	var in;
	in = PlayBuf.ar(1, buffer, rate, doneAction: 2);
	in = in * amp;
	Out.ar(out, Splay.ar(in));
}).store;

SynthDef(\bank_samples_no_env, {arg out=0, amp=0.5, rl=1, at=0.1, buffer=0, pos=0, rate=1/8;
	var in, fx, env;
	in = PlayBuf.ar(1, buffer, rate);
	in = in * amp;
	Out.ar(out, Pan2.ar(in, pos));
}).store;
);

	s.sync;
	// load osc listeners~responders
(
OSCdef(\ckar, {arg msg;
	var contents = msg[~view].asString.split($,);
	var seq = contents[0].findRegexpAt("[0-9]+", 2);
	var bank = contents[0].findRegexp("S.")[0][1].findRegexp("[0-9]")[0][1].asInt;
 var gen = contents[0].findRegexp("G.*S")[0][1].findRegexp("[0-9]+")[0][1].asInt;

	("view: " ++ ~view).postln;
	("contents: " ++ contents).postln;
	("seq: " ++ seq).postln;
	("bank: " ++ bank).postln;
	("gen: " ++ gen).postln;
	("rit: " ++ ~sub_division[gen].asString).postln;

	Tdef(~view.asSymbol, {
			var amp;
			var tree = ~view;
			var rit = ~sub_division;

			if (bank != 1) {if (f.delayCK.isPlaying) {f.delayCK.stop();} };

			~delaydecays[tree] = gen.linexp(2, 10, 0.5, 10);

		inf.do{|i|
			var num = (seq[0][i%(seq[0].size)]).asString.asInt;
					if (~reverb[tree]) {
						~r_out[tree] = ~buses['rev'][1];
					} {
						~r_out[tree] = 0;
					};

			switch(bank,
				7, {~amps['rev'].set(\bus, ~buses['rev'][1]); ~amps[tree].set(\out, ~buses['rev'][1]);
							if (~drones[tree].isPlaying) {~drones[tree].set(\midinote, ~oct_scale[num], \note, num, \amp, 1)} {
							t.sched(1, ~drones[tree] = Synth(\bank_drone, [\out, ~buses[tree].index, \midinote, ~oct_scale[num], \amp, 1, \eqfreq, 80, \note, num, \noise, 1, \rate, 3]).register;);
						}
						},
						2, {~amps['rev'].set(\bus, ~buses['rev'][1]); ~amps[tree].set(\out, ~buses['rev'][1]);
							if (~drones[tree].isPlaying) {~drones[tree].set(\midinote, ~oct_scale[num], \note, num, \amp, 1)} {
							t.sched(1, ~drones[tree] = Synth(\bank_drone, [\out, ~buses[tree].index, \midinote, ~oct_scale[num], \amp, 1, \offset, (7+12), \note, num, \noise, 1, \rate, 2]).register;);
						}
						},
						3, {~amps[tree].set(\out, ~buses['rev'][1]); if (num == 0) {amp = 0} {amp = 0.6}; t.sched(1,
							Synth(\bank_samples, [\out, ~buses[tree].index, \rl, rit[gen], \rate, 1, \amp, amp, \buffer, b[5][num], \pos, -1.rrand(1.0)]);
						)
						},
						4, {~amps[tree].set(\out, ~r_out[tree]); if (num == 0) {amp = 0} {amp = 1}; t.sched(1,
							Synth(\bank_samples_stereo, [\out, ~buses[tree].index, \amp, amp, \buffer, b[1][num]]); );
						},
				5, {~amps[tree].set(\out, ~r_out[tree]); if (num == 0) {amp = 0} {amp = 1}; t.sched(1,
								Synth(\bank1, [\out, ~buses[tree].index, \eqfreq, [100,345,543,657,789,987,2345,3456,6567][num-1], \amp, amp, \rl, rit[gen], \ratio, num, \rate, num]);
						)
						},
				6, {~amps[tree].set(\out, ~r_out[tree]); if (num == 0) {amp = 0} {amp = 0.7}; t.sched(1,
							Synth(\bank_samples, [\out, ~buses[tree].index, \rl, rit[gen], \rate, 1, \amp, amp, \buffer, b[4][num], \pos, -1.rrand(1.0)]); );
						},
						1, { f.delayCK(~delayamps[tree], ~delaywindow[tree], ~delaydecays[tree]); }
			);

					(rit[gen]).wait;
		};
	}).play;

	msg.postln;

}, 'ckartree');


	OSCdef(\ckar1, {arg msg;
			// ("VIEW: " + msg).postln;
	~view = msg[1].asInt;
	~view.postln;
}, 'ckartreeview');


		OSCdef(\ckar2, {arg msg;
			var key = msg[1].asString.split($,);
			var tree = key[0].findRegexpAt("[0-9]+")[0];
			var room = msg[2].linlin(-1, 1, 1, 30);

			msg.postln;

			~amps['rev'].set(\room, room);
			if (msg[4] > 0.5) {~reverb[~view] = true} {~reverb[~view] = false};

			~delaywindow[tree.asInteger] = msg[3].linlin(-1, 1, 0.125, 1);
		}, 'ckartreetransform');

OSCdef(\ckar3, {arg msg;
var key = msg[1].asString.split($,);
var tree = key[0].findRegexpAt("[0-9]+")[0];
var keyval = key[0].findRegexp("[a-z]+")[0][1];
var amp = msg[2].linexp(0.12, 0.7, -20.dbamp, 5.dbamp);

			if (keyval == "vel") {
~amps[tree.asInteger].set(\amp, amp);
~delayamps[tree.asInteger] = msg[2].linexp(0.12, 0.7, -15.dbamp, 6.dbamp);
			}

}, 'ckarvalue');

);


	s.sync;

// fx
	~amps['rev'] = Synth(\busplay_reverb, [\bus, ~buses['rev'][1].index, \amp, 0.4], addAction: 'addToTail').register;
	f = CkpianoFX(0, 0);
	s.sync;
	"\n************\n supercollider listening for sweet sweet L-sys and ready to eat chips \n************\n".postln;
};

/// notes:
// predecessor fix -
/// bug shape with collect -
/// map transform -
/// check reverb volume
///

//s.reboot;
//NetAddr.langPort
