 // universal
~path = thisProcess.nowExecutingPath.dirname
s.meter.window.alwaysOnTop_(true)
(~path ++ "/CodeKlavier_hybrid_huygens_NOCC_Pedal.scd").load; // special samples based on Air De Cour
// load the sampler:
{2.do{(~path ++ "/toypiano_sampler.scd").load; 2.wait}}.fork;

// mottipets:
(~path ++ "/snippets.scd").load;
(~path ++ "/CK_environment.scd").load;


//// codespace \\\\
n = NetAddr("127.0.0.1", 57120);

n.sendMsg("/huygens", "60");




~img.load;

x = {
loop{
n.sendMsg("/ck", 1.rrand(56).asString);
4.wait;
};
}.fork;

x.stop;
n.sendMsg("/ck_pp", "quote");n.sendMsg("/gong", "389");

~tremoloL1amp = 5;

~tremoloL1=1.rrand(16); ~tremoloM1=1.rrand(16); ~tremoloH1=1.rrand(14);
~tremoloL2=1.rrand(16); ~tremoloM2=1.rrand(16); ~tremoloH2=1.rrand(14);

/*
0 anne
1 voices
2 rhythm
3 fx
4 error
5 develop
*/

// wtf why onlu male voices?
(
OSCdef(\v, {|msg|
var num = msg[1];
if (num.asInt.odd) {
if (num%3 == 1) {
("say -v mark -r 99 " ++ num ++ "").unixCmd;
} {
("say -v pau -r 99 " ++ num ++ "").unixCmd;
Tdef(\s).stop;
Ndef(\s, {BPF.ar(WhiteNoise.ar(1)+Saw.kr("B2".namecps), LFTri.kr(3).range(100, 456))*0.8*EnvGen.kr(Env.perc(2, 8))}).play(0,1);
};
Tdef(\s, {
8.do{
Ndef(\s, {BPF.ar(WhiteNoise.ar(1), 234.rrand(978))*0.8*EnvGen.kr(Env.perc)}).play(0,1);
1.wait;
};}).play;
} {
if (num%4==0) {
    ("say -v tri -r 99 " ++ num ++ "").unixCmd;
    Tdef(\n, {
    ~name = Pseq([1,2,3,4,5], inf).asStream;
    8.do{
    Ndef(~name.next.asSymbol, {HPF.ar(WhiteNoise.ar(1), 7878)*0.8*EnvGen.kr(Env.perc(0.01,0.1))}).play(1,1);
    (1/4).wait;
    };}).play;
} {
("say -v ann -r 99 " ++ num ++ "").unixCmd;
Tdef(\n, {
~name = Pseq([1,2,3,4,5], inf).asStream;
16.do{
Ndef(~name.next.asSymbol, {HPF.ar(WhiteNoise.ar(1), 7878)*0.8*EnvGen.kr(Env.perc(0.01,0.1))}).play(1,1);
(1/4).wait;
};}).play;
    }
}
}, "/ck");
);

t = TempoClock.default.tempo_(83/60);

// ok

/// baaassss!!!
c = 0;
OSCdef(\n, {|msg|
    var rel = Pseq([8, 6, 2], inf).asStream;
    var num = rel.next;
("say -v juan -r 78 ztraik " ++ c.asString).unixCmd;
if (c < 30) {
Tdef(\b, {
loop{
Ndef(\bass, {LFPulse.kr(msg[0].asInt)*LPF.ar(WhiteNoise.ar(2)+SinOsc.ar(Line.kr(100,65,0.1), mul:2), 170)*EnvGen.kr(Env.perc(0.1, num))}).play(0,2);
(num).wait;
}}).play;
} {
2.wait;
Tdef.all.do{|i| i.stop;};
Ndef.all.do{|i| i.stop;};
Ndef(\bass, {LPF.ar(WhiteNoise.ar(10)*SinOsc.ar(Line.kr(100,65,0.1), mul:12), 170)*EnvGen.kr(Env.perc(0.1, num))}).play(0,2);
OSCdef.all.do{|i| i.free;};
};
c = c+1;
}, "/ck");
