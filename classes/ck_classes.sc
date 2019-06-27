/*
CK helper classes. Now for Ckalculator only.
2019
*/

CKpianoFX {
	classvar <>in=0, <>fadeT=4, <>out;

	*new {|input=0|
		in = input;
		^super.new.init(input);
	}

	init {|input|
		("FX node started with input channel " ++ input).postln;
		out=0;
	}

	typicalCK {|amp=0.2, freqs=0.5, size=4, dec=4|
		^Ndef("typicalFX".asSymbol, {GVerb.ar(PitchShift.ar(SoundIn.ar(in,2), 0.02, freqs),size, dec)*amp}).play(out,2).fadeTime_(fadeT);
	}

	delayCK {|amp=0.2, time=0.2, dec=3, tempo=1|
		^Ndef("delay".asSymbol, {CombC.ar(SoundIn.ar(in,2), tempo, time, dec)*amp}).play(out,2).fadeTime_(fadeT);
	}

	noisy {|amp=0.2, drive=0.2, mix=0.3, freq=189, q=0.2|
		("sniff " ++ this).postln;
		^Ndef("noisy".asSymbol, {FreeVerb.ar(SoundIn.ar(in,2)*RHPF.ar(BrownNoise.ar(drive.clip(0.01, 1)),freq,q), mix, 0.3)*amp}).play(out,2).fadeTime_(fadeT);
	}

}


Ckalculator {
	var <>num, <>voices=true, <>hirit=1, <>lrit=1, <>lout=0, <>hiout=0, <>hiamp=0.1, <>hifreq=8989, <>hiattack=0.01, <>hirel=0.01;
	var <>reciprocal=true, <>set_hi=true, <>set_l=true, <>voicevol=0.7;
	var <>harm_f1=261, <>harm_f2=1200, <>harm_f3=300, <>set_freq1=false, <>set_freq2=false, <>set_freq3=false;
	var <>harmony_freqs, <harmony_amp=0.1, <>laser_noise_freq=7989, <>laser_saw_freq=1889, <>laser_rel=0.2, <>laser_dec=0.5;
	var <>laser_amp=0.1, <non_number_count=0, <boolean, chunk=123, <>hugbuf, <>egg_text="";

	*new {|voice1="karen", voice2="oliver", voice3="tri"|
		^super.new.init(voice1, voice2, voice3)
	}

	init {|voice1, voice2, voice3|
		harmony_freqs = [harm_f1, harm_f2, harm_f3];

		// buffers
		hugbuf = Buffer.read(path:"/Users/narcodeb/Development/Repos/codeklavier-supercollider/Samples/huygens.wav");

		// comparisons
		OSCdef(\ckgt, {|msg|
			boolean = msg[1].asString.interpret;
			("say [[volm " ++ voicevol ++"]] -v " ++ voice1 ++ " -r 70 " ++ boolean.asString ++ "").unixCmd;
		}, '/ck_gt');

		OSCdef(\ckequal, {|msg|
			boolean = msg[1].asString.interpret;
			("say [[volm " ++ voicevol ++"]] -v " ++ voice2 ++ " -r 70 " ++ boolean.asString ++ "").unixCmd;
		}, '/ck_equal');

		OSCdef(\cklt, {|msg|
			boolean = msg[1].asString.interpret;
			("say [[volm " ++ voicevol ++"]] -v " ++ voice3 ++ " -r 70 " ++ boolean.asString ++ "").unixCmd;
		}, '/ck_lt');


		////////////////////////////// non sound \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

		OSCdef(\ckcalc_error, {|msg|
			// msg.postln;
			non_number_count = non_number_count + 1;
		}, '\ck_error');


		////////////////////////////////// sound \\\\\\\\\\\\\\\\\\\\\\\\\\

		// hihats
		Tdef(\ck_hi, {
			var prefix = Pwhite(0,10).asStream;
			var name = "hi".choose;
			loop{
				Ndef((prefix.next.asString++name).asSymbol, {HPF.ar(WhiteNoise.ar(1), hifreq)*hiamp*EnvGen.kr(Env.perc(hiattack, hirel))}).play([hiout,hiout+1].choose,1);
				(hirit.clip(0.01, 10)).wait;
			}
		});

		// hi lasers
		Tdef(\ck_lasers, {
			var prefix = Pwhite(0,10).asStream;
			var name = "hi2".choose;
			loop{
				Ndef((prefix.next.asString++name).asSymbol, {CombN.ar(Saw.ar(laser_saw_freq*Line.kr(4,1/2,0.1), 1)+RHPF.ar(WhiteNoise.ar(1).distort, laser_noise_freq, 0.2)*laser_amp*EnvGen.kr(Env.perc(0.01, laser_rel)), 0.2, 0.1, laser_dec)}).play([lout,lout+1].choose,1);
				(lrit.clip(0.05, 40)).wait;
		}});

		// harm
		Ndef(\ck_harm, {
			harmony_amp * GVerb.ar(Saw.ar(harm_f1/2).distort*SinOsc.ar([harm_f1*2*LFPulse.kr(1/2).range.(1, 3/2).lag(1), harm_f1, harm_f2*Line.kr(1/2, 1, 8), harm_f3]*1, mul:0.1), 88, 2, drylevel:LFNoise0.kr(2).range(0.1, 1));
		}).fadeTime_(3);

			// voices
		OSCdef(\cklac_voices, {|msg, time, addr, recvpPort|
			num = msg[1].asInt;

			if (reciprocal.not) {
				if (set_hi) { hirit = num; };
				if (set_l) { lrit = num; }
			} {
				if (set_hi) { hirit = num.reciprocal; };
				if (set_l) { lrit = num.reciprocal; }
			};

			if (num.odd) {
				if (voices) {	("say [[volm " ++ voicevol ++"]] -v " ++ voice1 ++ " " ++ num.asString).unixCmd; };
			} {
				if (voices) { ("say [[volm " ++ voicevol ++"]] -v " ++ voice2 ++ " " ++ num.asString).unixCmd; };
			};

			if (set_freq1 || set_freq2 || set_freq3) {
				[set_freq1, set_freq2, set_freq3].do{|val, freq|
					if (val) {
						harmony_freqs[freq] = num;
					};

					Ndef(\ck_harm, {
						harmony_amp * GVerb.ar(Saw.ar(harmony_freqs[0]/2).distort*SinOsc.ar([harmony_freqs[0]*2*LFPulse.kr(1/2).range.(1, 3/2).lag(1), harmony_freqs[0], harmony_freqs[1]*Line.kr(1/2, 1, 8), harmony_freqs[2]]*1, mul:0.1), 88, 2, drylevel:LFNoise0.kr(2).range(0.1, 1));
					});
				};
			};

		}, '/ck');

	}

	harmony_amp_ {|amp|
		Ndef(\ck_harm, {
			amp * GVerb.ar(Saw.ar(harm_f1/2).distort*SinOsc.ar([harm_f1*2*LFPulse.kr(1/2).range.(1, 3/2).lag(1), harm_f1, harm_f2*Line.kr(1/2, 1, 8), harm_f3]*1, mul:0.1), 88, 2, drylevel:LFNoise0.kr(2).range(0.1, 1));
		}).fadeTime_(3);
	}

	hi_noise {// source=true?
		hirit.postln;
		^Tdef(\ck_hi).play;
	}

	lasers {
		^Tdef(\ck_lasers).play;
	}

	harmony {|out=0|
		^Ndef(\ck_harm).play(out,2);
	}

	override_freqs {|freq1, freq2, freq3|
		harmony_freqs = [freq1, freq2, freq3];
		Ndef(\ck_harm, {
			harmony_amp * GVerb.ar(Saw.ar(harmony_freqs[0]/2).distort*SinOsc.ar([harmony_freqs[0]*2*LFPulse.kr(1/2).range.(1, 3/2).lag(1), harmony_freqs[0], harmony_freqs[1]*Line.kr(1/2, 1, 8), harmony_freqs[2]]*1, mul:0.1), 88, 2, drylevel:LFNoise0.kr(2).range(0.1, 1));
		});
	}

	// easter eggs
	easter_eggs {|amp=5, sustain=1, interpret=false|
		var names = Pseq([\huyg1, \huyg2, \huyg3, \huyg4], inf).asStream;
		^OSCdef(\ck_huyg, {|msg, time, addr, recvpPort|
			egg_text = msg[1];
			chunk = chunk + 1;
			sustain = sustain*1.1;
			Ndef(names.next, {FreeVerb.ar(amp*PlayBuf.ar(2, hugbuf.bufnum, -1, startPos: BufFrames.kr(hugbuf)*(chunk/90)).sum*EnvGen.kr(Env.perc(0.1, sustain)), 0.5, 0.95)}).play([0,1].choose,1);
			if (interpret) {egg_text.asString.interpret};
		}, '/ck_easteregg');
	}

}
