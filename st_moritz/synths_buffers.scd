/// synths and buffers
s.waitForBoot{
	MIDIIn.connectAll;
{
		(
	SynthDef(\sampleNarcode, {|out=0, at=0.01, rl=0.1, rate=1, start=0, amp=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd;
	snd = PlayBuf.ar(1, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*start)*env;
	Out.ar(out, snd*amp);
}).store;
	SynthDef(\sampleNarcodeStr, {|out=0, at=0.01, rl=0.1, rate=1, start=0, amp=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd;
	snd = PlayBuf.ar(2, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*start)*env;
	Out.ar(out, snd*amp);
}).store;
	s.sync;
SynthDef(\act, {|out=0, rt=1, at=0.01, amp=1, rate=1, buf, cut=1600|
var snd, fx;
	snd=PlayBuf.ar(2, buf, rate)*EnvGen.kr(Env.perc(attackTime: at, releaseTime:rt), doneAction: 2);
	fx = LPF.ar(snd, cut);
	Out.ar(out, fx*amp);
}).store;
		);
s.sync;
(// basic
~buffers = ();
~buffers['africa'] = ();
~buffers['samerica'] = ();
~buffers['namerica'] = ();
~buffers['oceania'] = ();
~buffers['antarctica'] = ();
~buffers['europe'] = ();
~buffers['asia'] = ();
~path_samples = thisProcess.nowExecutingPath.dirname ++ "/";
~path_samples_as = thisProcess.nowExecutingPath.dirname ++ "/asia/";
~path_samples_af = thisProcess.nowExecutingPath.dirname ++ "/africa/";
~path_samples_sa = thisProcess.nowExecutingPath.dirname ++ "/southamerica/";
~path_samples_na = thisProcess.nowExecutingPath.dirname ++ "/northamerica/";
~path_samples_o = thisProcess.nowExecutingPath.dirname ++ "/oceania/";
~path_samples_an = thisProcess.nowExecutingPath.dirname ++ "/antarctica/";
~path_samples_e = thisProcess.nowExecutingPath.dirname ++ "/europe/";

~buffers['asia'][0] = Buffer.read(s, ~path_samples_as ++ "bell.wav");

~buffers['africa'][0] = Buffer.read(s, ~path_samples_af ++ "perc1.wav");
~buffers['africa'][1] = Buffer.read(s, ~path_samples_af ++ "kalimba.wav");
~buffers['africa'][2] = Buffer.read(s, ~path_samples_af ++ "perc2.wav");

~buffers['samerica'][1] = Buffer.read(s, ~path_samples_sa ++ "amazon.wav");
8.do{|i|
	~buffers['namerica'][i] = Buffer.read(s, ~path_samples_na ++ "trio_" ++ (i+1).asString ++ ".wav");
};
~buffers['oceania'][0] = Buffer.read(s, ~path_samples_o ++ "sea.wav");
~buffers['oceania'][1] = Buffer.read(s, ~path_samples_o ++ "kookaburra.wav");
~buffers['oceania'][2] = Buffer.read(s, ~path_samples_o ++ "didgeridookook.wav");
~buffers['oceania'][3] = Buffer.read(s, ~path_samples_o ++ "drone.wav");

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
}.fork;
};