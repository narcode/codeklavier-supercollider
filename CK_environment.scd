// CodeKlavier Environment

// load Huygens sample
~path = thisProcess.nowExecutingPath.dirname;
~hugbuf = Buffer.read(s, ~path++"/Samples/huygens.wav");
"Huygens sample loaded...".postln;

~stop = Environment[
'now' -> {|self|
"stopping".postln;
SkipJack.stop("pedalwatch");
~hello.stop;
~hello2.stop;
~hello3.stop;
~ost.stop;
~ost1.stop;
~ost2.stop;
~down=0;~down1=0;~down2=0;
~op=0;~op1=0;~op2=0;
}
];

~stop.know = true;

~huygens = Environment[
'stuk' -> {|self, chunk|
Ndef(\huyg, {FreeVerb.ar(4*PlayBuf.ar(2, ~hugbuf, startPos: BufFrames.kr(~hugbuf)*(chunk/90)).sum*EnvGen.kr(Env.perc(0.1, 2.rrand(5))), 0.5, 0.95)}).play([0,1].choose,1);
},
'eind' -> {|self|
    Ndef(\huyg, {FreeVerb.ar(FreqShift.ar(PlayBuf.ar(2, ~hugbuf, startPos: 0).sum, LFNoise1.kr([4, 1]).range(-10, 10)*Line.kr(1,0,6)), Line.kr(1, 0.1, 16), 1)*EnvGen.kr(Env.linen(0.01, 22, 15.5))}).play([0,1].choose,1);
}
];

~huygens.know = true
