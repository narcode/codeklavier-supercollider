/// synths and buffers
s.waitForBoot{
	MIDIIn.connectAll;
{
	SynthDef(\sampleNarcode, {|out=0, at=0.01, rl=0.1, rate=1, pos=0, amp=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd;
	snd = PlayBuf.ar(1, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*pos)*env;
	Out.ar(out, snd*amp);
}).store;
	SynthDef(\sampleNarcodeStr, {|out=0, at=0.01, rl=0.1, rate=1, pos=0, amp=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd;
	snd = PlayBuf.ar(2, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*pos)*env;
	Out.ar(out, snd*amp);
}).store;
	s.sync;
SynthDef(\act, {|out=0, rt=1, at=0.01, amp=1, rate=1, buf, cut=1600|
var snd, fx;
	snd=PlayBuf.ar(2, buf, rate)*EnvGen.kr(Env.perc(attackTime: at, releaseTime:rt), doneAction: 2);
	fx = LPF.ar(snd, cut);
	Out.ar(out, fx*amp);
}).store;
s.sync;
(// basic
~buffers = ();
~buffers['africa'] = ();
~buffers['samerica'] = ();
~buffers['namerica'] = ();
~buffers['oceania'] = ();
~buffers['antarctica'] = ();
~buffers['europe'] = ();
~path_samples = thisProcess.nowExecutingPath.dirname ++ "/";
~path_samples_af = thisProcess.nowExecutingPath.dirname ++ "/africa/";
~path_samples_sa = thisProcess.nowExecutingPath.dirname ++ "/southamerica/";
~path_samples_na = thisProcess.nowExecutingPath.dirname ++ "/northamerica/";
~path_samples_o = thisProcess.nowExecutingPath.dirname ++ "/oceania/";
~path_samples_an = thisProcess.nowExecutingPath.dirname ++ "/antarctica/";
~path_samples_e = thisProcess.nowExecutingPath.dirname ++ "/europe/";
~buffers['africa'][0] = Buffer.read(s, ~path_samples_af ++ "africa.wav");
~buffers['africa'][1] = Buffer.read(s, ~path_samples_af ++ "kalimba.wav");
~buffers['samerica'][1] = Buffer.read(s, ~path_samples_sa ++ "amazon.wav");
8.do{|i|
	~buffers['namerica'][i] = Buffer.read(s, ~path_samples_na ++ "trio_" ++ (i+1).asString ++ ".wav");
};
~buffers['oceania'][0] = Buffer.read(s, ~path_samples_o ++ "sea.wav");
~buffers['oceania'][1] = Buffer.read(s, ~path_samples_o ++ "kookaburra.wav");
~buffers['oceania'][2] = Buffer.read(s, ~path_samples_o ++ "didgeridookook.wav");

~buffers['antarctica'][0] = Buffer.read(s, ~path_samples_an ++ "8.wav");
~buffers['antarctica'][1] = Buffer.read(s, ~path_samples_an ++ "600.wav");
~buffers['antarctica'][2] = Buffer.read(s, ~path_samples_an ++ "30.wav");
~buffers['antarctica'][3] = Buffer.read(s, ~path_samples_an ++ "23.wav");
~buffers['antarctica'][4] = Buffer.read(s, ~path_samples_an ++ "iceshelf.wav");

~buffers['europe'][0] = Buffer.read(s, ~path_samples_e ++ "italians_singing.wav");
~buffers['europe'][1] = Buffer.read(s, ~path_samples_e ++ "130.wav");
~buffers['europe'][2] = Buffer.read(s, ~path_samples_e ++ "beethoven.wav");

~buffers['bd'] = Buffer.read(s, ~path_samples ++ "808bd.wav");
~buffers['hh'] = Buffer.read(s, ~path_samples ++ "808hh.wav");
~buffers['sn'] = Buffer.read(s, ~path_samples ++ "808sd.wav");
);
s.sync;
"=> all buffers and synths loaded".postln;
	s.sync;
	(
m = {arg item, itemarg, debug, one=0, two=0, three=0, four=0;
	Routine{
		if (debug) {[one,two,three,four].asString.postln;};

		[one, two, three, four].do{arg beat, index;
			if (beat.isArray.not) { // single:
				if (beat > 0) {
					if (debug) {(index.asString ++ " = " ++ beat.asString).postln;};
					(beat.reciprocal.clip(1, ~maxsubdiv)).do{
						item.(itemarg);
						(beat.clip(~maxsubdiv.reciprocal, 1)).wait;
					};
				} {1.wait};
			} { // array:
				{
					beat.do{arg sub;
						if (sub > 0) {
							if (debug) {(beat.asString ++ " = " ++ beat.asString ++ sub.asString).postln;};
							((sub).clip(1, ~maxsubdiv)).do{
								item.(itemarg);
								if (sub == 1) {
									(sub/beat.size).wait;
								} {(beat.size.reciprocal/sub).wait;}
						}} {(beat.size.reciprocal).wait;}
					};

						(beat.size.reciprocal).wait;

				}.fork;
				1.wait;
			};
		};
};
});
	s.sync;
(
h = {arg chord=nil, bass=nil, rel=2.5, bamp=0.6, champ=0.1;
	if (chord.isNil.not && chord.isString.not) {
		Ndef(\h, {SinOsc.ar([chord, chord*LFNoise1.kr(1/8).range(1,2)], 0, [1, 1/89])*champ*EnvGen.kr(Env.perc(1*t.tempo, 1*t.tempo), doneAction:2);}).play(60,2, g);};
	if (bass.isNil.not || chord.isString) {
		if (bass.isNil) {
			Ndef(\hb, {SinOsc.ar((chord).namecps, mul:bamp)*EnvGen.kr(Env.perc(0.1, rel*t.tempo), doneAction:2)}).play(0);
		} {
	Ndef(\hb, {SinOsc.ar((bass).namecps, mul:bamp)*EnvGen.kr(Env.perc(0.1, rel*t.tempo), doneAction:2)}).play(0);
		};
	};
};
);
	s.sync;
	(
r = Routine{
	inf.do{
		s.bind{
			// audio
			~funcs.do{|f| f.(); };
		};
		4.wait; // must be dynamic
	}
};
);
	s.sync;
~maxsubdiv = 12;
~minsubdiv = 12;
~funcs = ();
	s.sync;
	"=> PZ Beat machine loaded".postln;
}.fork;
};