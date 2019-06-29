/cktree
/cktreeview
/cktreetransform (position, rotation, scale)
~view = 1;
// process delete
(
OSCdef(\ckar, {arg msg;
	var contents = msg[~view].asString.split($,);
	var seq = contents[0].findRegexpAt("[0-9]+", 2);
	var bank = contents[0].findRegexp(".$")[0][1].asInt;
	var name = [\1,\2,\3,\4,\5].asStream;
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
				1, {if (num == 0) {amp = 0} {amp = 1}; rit = 1/4; Synth(\bank1, [\eqfreq, [789,234,123,456,6788,123,4562,889,25][num], \amp, amp, \rl, rit, \ratio, num, \rate, num])},
				2, {rit = 1; Synth(\bank_samples, [\buffer, b[num], \rl, 1.rrand(5)*rit, \pos, -1.rrand(1)])},
				3, {rit = 5; if (a.isPlaying) {a.set(\pratio, num)} {a = Synth(\bank3_fx, [\amp, 2, \in, 0, \pratio, num]).register;}; }
			);

					(rit).wait;
		};
	}).play;
	msg.postln;
}, 'cktree');
);

OSCdef(\ckar1, {arg msg;
("VIEW: " + msg).postln;
	~view = msg[1].asInt;
	~view.postln;
}, 'cktreeview');

OSCdef(\ckar2, {arg msg;
	("TRANSFORM: " + msg).postln;
}, 'cktreetransform');

c - g - a - e
0 - 5 - 6 - 3

5 - clock
0 - silence
6 - pum
3 - klick
a.isPlaying
(
SynthDef(\bank1, {arg out=0, amp=1, rl=1, at=0.1, freq=123, eqfreq=789, ratio=1, rate=1;
	var in, fx, env;
	env = EnvGen.kr(Env.perc(at, rl), doneAction: 2);
	in = BrownNoise.ar(LFPulse.kr(ratio)*0.5);
	fx = BPF.ar(in, eqfreq, LFNoise0.kr(rate).range(0.01, 1));
	in = fx * env * amp;
	Out.ar(out, Pan2.ar(in, LFTri.kr(rate).range(-1, 1)));
}).store;

SynthDef(\bank3_fx, {arg out=0, in=0, amp=1, rl=99, at=0.1, pratio=1;
	var input, fx, env;
	env = EnvGen.kr(Env.linen(at, rl), doneAction: 2);
	input = SoundIn.ar(In.ar(in,2));
	fx = CombN.ar(PitchShift.ar(input, 0.2, [1/pratio, LFSaw.kr(1/pratio).range(0.25,1.5/pratio), 3/pratio, pratio/4]), 0.2, 3);
	input = fx * env * amp;
	Out.ar(out, Splay.ar(input));
}).store;

SynthDef(\bank_samples, {arg out=0, amp=1, rl=1, at=0.1, buffer=0, pos=0;
	var in, fx, env;
	env = EnvGen.kr(Env.perc(at, rl), doneAction: 2);
	in = PlayBuf.ar(2, buffer);
	in = in * env * amp;
	Out.ar(out, Pan2.ar(in, pos));
}).store;
);

b = ();
8.do{|i|
	i = i+1;
	b[i] = Buffer.read(s, "/Users/narcodeb/Development/Repos/codeklavier-supercollider/ck_ar/soundbanks/nasa/"++i.asString++".wav");
}


