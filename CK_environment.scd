// CodeKlavier Environment

// load Huygens sample
~path = thisProcess.nowExecutingPath.dirname;
~hugbuf = Buffer.read(s, ~path++"/Samples/huygens.wav");
~hugbuf2 = Buffer.read(s, ~path++"/Samples/huygens2.wav");

"Huygens samples loaded...".postln;

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
t.tempo = 1;
SkipJack.stop("pedalwatch");
(~path ++ "/snippets.scd").load;
}
];

~sustain = 0.5;
~names = Pseq([\huyg1, \huyg2, \huyg3, \huyg4], inf).asStream;

~huygens = Environment[
'stuk' -> {|self, chunk|
Ndef(~names.next, {FreeVerb.ar(2.5*PlayBuf.ar(2, ~hugbuf, rate: [1, -1].choose, startPos: BufFrames.kr(~hugbuf)*(chunk/90)).sum*EnvGen.kr(Env.perc(0.1, ~sustain)), 0.5, 0.95)}).play([0,1].choose,1);
~sustain = ~sustain*1.1;
},
'end' -> {|self|
    Ndef.all.do{|n| n.stop(13.rrand(15))};
    Ndef(\huyg, {FreeVerb.ar(FreqShift.ar(PlayBuf.ar(2, ~hugbuf2, startPos: 0).sum, LFNoise1.kr([4, 1]).range(-10, 10)*Line.kr(1,0,6)), Line.kr(1, 0.1, 20), 1)}).play([0,1].choose,1);
    ~snippet2.stop;
    ~snippet1.stop;
}
];

~gong = Environment[
'play' -> {|self, freq_offset|
Ndef(\gong, {FreeVerb.ar(Splay.ar(WhiteNoise.ar(Impulse.kr(0.2))+SinOsc.ar([(1234+freq_offset)*LFTri.kr(0.1.rrand(18)).range(0.98, 1.02), 150, 299, 544*Line.kr(1, 2, 6), 1789]))*EnvGen.kr(Env.perc), 0.5, 0.95)}).play;
}
];


~stop.know = true;
~huygens.know = true;
~gong.know = true;
