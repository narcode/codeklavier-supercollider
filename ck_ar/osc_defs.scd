/*
addresses:
/cktree
/cktreeview
/cktreetransform (position, rotation, scale)
*/

s.meter.window.alwaysOnTop_(false);
s.reboot;
s.waitForBoot{
	// ini vars:
	~view = 1;
	h = Group.new(s);
	~path = thisProcess.nowExecutingPath.dirname ++ "/soundbanks/";
	// load soundbanks
	(
b = ();
b[1] = ();	b[2] = ();	b[3] = ();	b[4] = ();
9.do{|i|
	i = i+1;
	b[1][i] = Buffer.read(s, ~path ++ "808bd/" ++ i.asString ++ ".wav");
	b[2][i] = Buffer.read(s, ~path ++ "808hh/" ++ i.asString ++ ".wav");
	b[3][i] = Buffer.read(s, ~path ++ "808sd/" ++ i.asString ++ ".wav");
	b[4][i] = Buffer.read(s, ~path ++ "nasa/" ++ i.asString ++ "_mono.wav");

}
);

	s.sync;

// load synthdefs
(
SynthDef(\bank1, {arg out=0, amp=1, rl=1, at=0.1, freq=123, eqfreq=789, ratio=1, rate=1;
	var in, fx, env;
	env = EnvGen.kr(Env.perc(at, rl), doneAction: 2);
	in = BrownNoise.ar(LFPulse.kr(ratio)*0.5);
	fx = BPF.ar(in, eqfreq, LFNoise0.kr(rate).range(0.01, 1));
	in = fx * env * amp;
	Out.ar(out, Pan2.ar(in, LFTri.kr(rate).range(-1, 1)));
}).store;

SynthDef(\bank_drone, {arg out=0, amp=1, rl=1, at=0.1, st=30, midinote=24, eqfreq=789, ratio=1, rate=1, note=0;
	var in, fx, env, in2, in3;
	env = EnvGen.kr(Env.linen(at, st, rl), doneAction: 2);
	in = BrownNoise.ar(LFNoise0.kr((21+note).midicps).range(0, 0.05))*LFNoise2.kr(8).range(0.01, 1);
	in2 = SinOsc.ar([midinote.midicps, (midinote-3).midicps, (midinote+7).midicps]+note, 0, [1,0.3, 0.1]) * 0.2;
			in3 = SinOsc.ar([(midinote+24+note).midicps, (midinote+36+note).midicps, (midinote+5+note).midicps].postln, 0, [1,0.3, 0.1]) * 0.2;
	in = (in * in2) + in2 + in3;
	fx = BPF.ar(in, eqfreq, LFNoise1.kr(rate).range(0.01, 1));
	in = fx * env * amp;
	Out.ar(out, Splay.ar(Limiter.ar(in.sum), 0.9));
}).store;

SynthDef(\bank_drone2, {arg out=0, amp=0.5, rl=1, at=0.1, st=30, midinote=21, eqfreq=789, ratio=2, rate=5, note=0;
	var in, fx, env, in2, in3;
	env = EnvGen.kr(Env.linen(at, st, rl), doneAction: 2);
	in = BrownNoise.ar(LFNoise0.kr((21+note).midicps).range(0, 0.05))*LFNoise2.kr(8).range(0.01, 1);
	in2 = SinOsc.ar([midinote.midicps, (midinote-3).midicps, (midinote+12).midicps]+note, 0, [1,0.3, 0.1]) * 0.2;
			in3 = SinOsc.ar([(midinote+33+note).midicps, (midinote+42+note).midicps, (midinote+5+note).midicps].postln, 0, [1,0.3, 0.1]) * 0.1;
	in = (in * in2) + in2 + in3;
	fx = BPF.ar(in, eqfreq, LFNoise1.kr(rate).range(0.01, 1));
	in = fx * env * amp;
	Out.ar(out, Splay.ar(Limiter.ar(in.sum), 0.9));
}).store;

SynthDef(\bank_drone3, {arg out=0, amp=0.5, rl=1, at=0.1, st=30, midinote=21, eqfreq=389, ratio=4, rate=1, note=0;
	var in, fx, env, in2, in3;
	env = EnvGen.kr(Env.linen(at, st, rl), doneAction: 2);
	in = BrownNoise.ar(LFNoise0.kr((21+note).midicps).range(0, 0.05))*LFNoise2.kr(8).range(0.01, 1);
	in2 = SinOsc.ar([midinote.midicps, (midinote-3).midicps, (midinote+19).midicps]+note, 0, [1,0.3, 0.1]) * 0.2;
			in3 = SinOsc.ar([(midinote+33+note).midicps, (midinote+42+note).midicps, (midinote+5+note).midicps].postln, 0, [1,0.3, 0.1]) * 0.1;
	in = (in * in2) + in2 + in3;
	fx = BPF.ar(in, eqfreq, LFNoise1.kr(rate).range(0.01, 1));
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
//SoundIn.ar(2,1
SynthDef(\bank_samples, {arg out=0, amp=1, rl=1, at=0.1, buffer=0, pos=0, rate=1;
	var in, fx, env;
	env = EnvGen.kr(Env.perc(at, rl), doneAction: 2);
	in = PlayBuf.ar(1, buffer, rate);
	in = in * env * amp;
	Out.ar(out, Pan2.ar(in, pos));
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
	var bank = contents[0].findRegexp(".$")[0][1].asInt;

		("view: " ++ ~view).postln;
		("contents: " ++ contents).postln;
			("seq: " ++ seq).postln;
	("bank: " ++ bank).postln;

	Tdef(~view.asSymbol, {
		inf.do{|i|
			var num = (seq[0][i%(seq[0].size)]).asString.asInt;
			var amp;
			var rit = 1;

			switch(bank,
				1, {rit = 2; if (a.isPlaying) {a.set(\note, num)} {a = Synth(\bank_drone, [\out, 2, \midinote, 21, \amp,1, \note, num], h).register;} },
				2, {rit = 1; if (c.isPlaying) {c.set(\note, num)} {c = Synth(\bank_drone2, [\out, 2, \midinote, 25, \amp,0.5, \note, num], h).register;} },
				3, {rit = 7; if (d.isPlaying) {d.set(\note, num)} {d = Synth(\bank_drone3, [\out, 2, \midinote, 14, \amp,0.3, \note, num], h).register;} },
				5, {if (num == 0) {amp = 0} {amp = 1}; rit = 1/4; Synth(\bank1, [\eqfreq, [100,345,543,657,789,987,2345,3456,6567][num-1], \amp, amp, \rl, rit, \ratio, num, \rate, num])}, // low generation == whistle
				//3, {if (num == 0) {amp = 0} {amp = 4}; rit = 1/2; Synth(\bank_samples, [\amp, amp, \buffer, b[2][num], \rl, 1.rrand(5)*rit, \pos, -1.rrand(1.0)])},
				4, {if (num == 0) {amp = 0} {amp = 2}; rit = 1/2; Synth(\bank_samples, [\amp, amp, \buffer, b[1][num], \rl, 1.rrand(5)*rit, \pos, -1.rrand(1.0)])},
				//6, {if (num == 0) {amp = 0} {amp = 0.5}; rit = 2; Synth(\bank_samples_no_env, [\rate, 1, \amp, amp, \buffer, b[4][num], \pos, -1.rrand(1.0)])},
				7, {if (num == 0) {amp = 0} {amp = 1}; rit = 1/8; Synth(\bank_samples, [\amp, amp, \buffer, b[3][num], \rl, 0.2.rrand(0.01)*rit, \pos, -1.rrand(1.0)])},
				6, {rit = 5; if (a.isPlaying) {a.set(\pratio, num)} {a = Synth(\bank3_fx, [\amp, 2, \in, 0, \pratio, num]).register;}; }
			);

					(rit).wait;
		};
	}).play;

	msg.postln;

}, 'cktree');


OSCdef(\ckar1, {arg msg;
("VIEW: " + msg).postln;
	~view = msg[1].asInt;
	~view.postln;
}, 'cktreeview');

OSCdef(\ckar2, {arg msg;
	("TRANSFORM: " + msg).postln;
}, 'cktreetransform');

);

	s.sync;

// fx
Ndef(\rev, {GVerb.ar(In.ar(2,2), 89, 8)*2}).play(0,2);
	s.sync;
	"\n************\n supercollider listening for sweet sweet L-sys and ready to eat chips \n************\n".postln;
};
