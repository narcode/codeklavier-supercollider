MIDIClient.init;

m = MIDIOut(0);

(
~successor = m.noteOn(0, 95, 60);
~zero = m.noteOn(0, 59,60);
~pred = m.noteOn(0, 47, 60);
~add = m.noteOn(0, 83, 60);
~sub = m.noteOn(0, 35, 60);
~mult = m.noteOn(0, 107, 60);
~div = m.noteOn(0, 23, 60);
~equal = m.noteOn(0, 74, 60);
~gt = m.noteOn(0, 73, 60);
~lt = m.noteOn(0, 75, 60);
~eval = m.noteOn(0, 71, 60);
)

{
1150.do{|i|
		m.noteOn(0, 59.rrand(100), 60);
		i.postln;
	0.005.wait;
}
}.fork;



// osc:


// karen says ODD nums and tri says EVEN
OSCdef(\ck, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
	val.postln;
	if (val%2 == 0) {
			("say -v tri -r " ++ msg[1] ++ " " ++ msg[1]++ "").unixCmd;

	} {
	("say -v karen -r " ++ msg[1] ++ " " ++ msg[1]++ "").unixCmd;
	}
}, '/ck');


// now i will add an fx to the piano:
OSCdef(\ckp, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
	Ndef(\fx1, {CombC.ar(FreqShift.ar(SoundIn.ar(8,9), val), 0.2, val/100, [6, 3])*0.5}).play(0,2)
}, '/ck');


/// now an fx for the piano:
OSCdef(\ckr, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
	Ndef(\fx, {GVerb.ar(FreqShift.ar(SoundIn.ar(0,2), 0.2, val), val.linlin(1, 123, 1, 123), 4)}).play
}, '/ck');


OSCdef(\ck2, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
	val.postln;
	if (val > 50) {
				Ndef(\a).set(\amp, 0.1);
	Ndef(\w, {|amp=1| amp*LPF.ar(WhiteNoise.ar(1), val.linlin(0, 1000, 24, 7898))*LFPulse.kr(val)}).play;
	} {
		Ndef(\w).set(\amp, 0.1);
	Ndef(\a, {|amp=1| amp*SinOsc.ar(400*LFTri.kr(1).range(1/2, 4))*LFPulse.kr(1)}).play;
	}
}, '/ck');




OSCdef(\ck2, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
	val.postln;
	if (val < 99 && val > 21) {
			val.midicps.postln;
		Ndef(\tri, {SinOsc.ar(val.midicps*1)*0.2*LFPulse.kr(val/4)}).play;
	}
}, '/ck');


OSCdef(\ck, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
		var amp = 0.1;
	var offset = 3;
	val.postln;
	if (~gt == true) {
		offset = 10;
	};
	if (val.odd) { // IF VALUE IS ODD:
		if (val > 50) { // IF VALUE MORE THAN 50 PLAY I ortherwise play V
			Ndef(\h, {Saw.ar(["B2".namecps, "d#3".namecps]*LFTri.kr(offset).range(1, 1.5))*amp*LFPulse.kr(val/10).lag(0.2).range(0.1, 1)}).play;
		} {
			Ndef(\h, {Saw.ar(["f#2".namecps, "a#3".namecps]*LFTri.kr(offset).range(1, 1.5))*amp*LFPulse.kr(val/10).lag(0.2).range(0.1, 1)}).play;
		}
	} {
		if (val > 50) { // go to minor
		Ndef(\h, {Saw.ar(["a2".namecps, "f3".namecps]*LFTri.kr(offset).range(1, 1.5))*amp*LFPulse.kr(val/10).lag(0.2).range(0.2, 1)}).play;
		} {
						Ndef(\h, {Saw.ar(["d2".namecps, "B3".namecps]*LFTri.kr(offset).range(1, 1.5))*amp*LFPulse.kr(val/10).lag(0.2).range(0.1, 1)}).play;
		}
	}
}, '/ck');


~mel = Pseq(["B4".namecps, "B5".namecps, "B6".namecps, "B7".namecps], inf).asStream;
OSCdef(\ckm, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
	val.postln;
	Ndef(\m, {FreqShift.ar(SinGrain.ar(Impulse.kr(val%8), 0.2, ~mel.next), val)*0.8}).play(1,1);
}, '/ck');

//  i will make a beat:

OSCdef(\ckb, {|msg, time, addr, recvPort|
	var val = msg[1].asInt;
	var names = Pseq([\n, \a, \r, \c], inf).asStream;
	val.postln;
	if (val.even) {
	Tdef(\beat, {
		loop{
			Ndef(names.next, {FreqShift.ar(WhiteNoise.ar(1), val)*EnvGen.kr(Env.perc(0.01, 1))}).play(1,1);
			(val/10).wait;
		}
	}).play;
	}
}, '/ck');

~gt = false;
~lt = false;
~equal = false;

OSCdef(\ckgt, {|msg, time, addr, recvPort|
	msg.postln;
	~gt = msg[1];
	("say -v bad -r 70 " ++ msg[1] ++ "").unixCmd;
}, '/ck_gt');

OSCdef(\ckequal, {|msg, time, addr, recvPort|
	msg.postln;
		~equal = msg[1];
		("say -v prin -r 70 " ++ msg[1] ++ "").unixCmd;
}, '/ck_equal');

OSCdef(\cklt, {|msg, time, addr, recvPort|
	msg.postln;
		~lt = msg[1];
			("say -v good -r 70 " ++ msg[1] ++ "").unixCmd;
}, '/ck_lt');


OSCdef(\ck_voice, {|msg|
	var num = msg[1].asInt;
	if (num.odd) {
		("say -v tri -r " ++ num ++ " " ++ num ++ "").unixCmd;
	}{
		("say -v xa -r " ++ num ++ " " ++ num ++ "").unixCmd;
	}
}, '/ck');


OSCdef(\ck1, {|msg|
	var num = msg[1].asInt;
	if (~gt == 'true') {
		Ndef(\n, {Saw.ar(num.midicps)*0.1}).play(0,1)
	} {
		Ndef(\n, {Saw.ar("E1".namecps)*LFPulse.kr(num)*0.1}).play(1,1)
	}
}, '/ck');

OSCdef(\ck2, {|msg|
	var num = msg[1].asInt;
	if (~lt == 'true') {
		Ndef(\na, {(SinOsc.ar(Line.kr(99, 50, 0.2))+WhiteNoise.ar(0.8))*EnvGen.kr(Env.perc)*0.2}).play(0,1)
	} {
		Ndef(\na, {(HPF.ar(WhiteNoise.ar(0.8), 7878))*EnvGen.kr(Env.perc(0.1, 0.1))*0.2}).play(0,1)
	}
}, '/ck');


//// ENV:
(
~gt = 'false';
~lt = 'false';
~equal = 'false';

~comparisons = Environment[
'on' -> {|self, voice1, voice2, voice3|
		{
		OSCdef(\ckgt, {|msg|
	msg.postln;
	~gt = msg[1];
			("say -v" ++ voice1 ++ "-r 70 " ++ msg[1] ++ "").unixCmd;
}, '/ck_gt');

OSCdef(\ckequal, {|msg|
	msg.postln;
		~equal = msg[1];
		("say -v " ++ voice2 ++ " -r 70 " ++ msg[1] ++ "").unixCmd;
}, '/ck_equal');

OSCdef(\cklt, {|msg|
	msg.postln;
		~lt = msg[1];
			("say -v " ++ voice3 ++ " -r 70 " ++ msg[1] ++ "").unixCmd;
}, '/ck_lt');
		}.fork;
	}
];

// OSCdef(\ck_gong, {|msg, time, addr, recvPort|
// 	var freq_offset = msg[1].asFloat;
// 	Ndef(\gong, {~gongamp*FreeVerb.ar(Splay.ar(WhiteNoise.ar(Impulse.kr(0.2))+SinOsc.ar([(1234+freq_offset)*LFTri.kr(0.1.rrand(18)).range(0.98, 1.02), 150, 299, 544*Line.kr(1, 2, 6), 1789])).sum*EnvGen.kr(Env.perc), 0.5, 0.95)}).play;
// }, '/ck_easteregg');
);

~comparisons.know = true;

~path = thisProcess.nowExecutingPath.dirname;
~hugbuf = Buffer.read(s, ~path++"/Samples/huygens.wav");
~hugbuf2 = Buffer.read(s, ~path++"/Samples/huygens2.wav");

// global amp variables:
~gongamp = 1.6;
~huygensamp = 5;
~sustain = 1;
~names = Pseq([\huyg1, \huyg2, \huyg3, \huyg4], inf).asStream;
~chunk = 123;

(
OSCdef(\ck_huyg, {|msg, time, addr, recvpPort|
	msg[1].postln;
~chunk = ~chunk+1;
	Ndef(~names.next, {FreeVerb.ar(~huygensamp*PlayBuf.ar(2, ~hugbuf.bufnum, -1, startPos: BufFrames.kr(~hugbuf)*(~chunk/90)).sum*EnvGen.kr(Env.perc(0.1, ~sustain)), 0.5, 0.95)}).play([0,1].choose,1);
~sustain = ~sustain*1.1;
}, '/ck_easteregg');
);

