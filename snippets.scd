/*

snippets for Mottipets

*/
s.waitForBoot({
	"starting server...".postln;

~ts = TempoClock.new();
~ts.tempo = 20/60;
s.sync;
// snippet 1: beat
/*r = ();*/
/*[1,2,3,4,5,6].do{|i| r[i] = 1};*/
s.sync;
~amp1 = 0.1;
~rit = Pseq([Pfuncn({r[1]},1), Pfuncn({r[2]},1), Pfuncn({r[3]},1), Pfuncn({r[4]},1)], inf).asStream;
~topR = 3000;
~rit2 = 1;
~name = Pseq([\pulse, \pulse2, \pulse3, \pulse4, \pulse5, \pulse6],inf).asStream;
~tremoloM = 4;
~tremoloH = 16;
~tremoloL = 2;
~tremoloL1 = 1;
~tremoloL2 = 1;
~tremoloL1amp = 1;
~tremoloM1 = 6;
~tremoloM2 = 1;
~tremoloM3 = 1;
~tremoloH1 = 2;
~tremoloH2 = 1;
~rit = 0.1;
~pnoamp = 0.25;
~ostamp = 0.25;
~ampacc= 0.4;
~map_rhythm = false;
~map_amplitude = false;
~t = 1;
s.sync;

//loop listener? is there a better solution?
Tdef(\listenerkr, {
  loop{

// sampler
	if (~map_amp_ost == true) { ~ostamp = ~tremoloM1.linlin(1, 20, 0.01, 1); }; // rit
	if (~map_amp_tp == true) { ~amp_tp = ~tremoloM1.linlin(1, 16, 0.01, 1.5); }; // rit
	if (~map_amp_org == true) { ~amp_org = ~tremoloM3.linlin(1, 16, 0.1, 10); }; // rit
// snippet 1
	if (~map_rhythm == true) { Ndef(\krm1_r, {~tremoloL1.linlin(1, 16, 1/2, 18)}) }; // rit
	if (~map_amplitude == true) { Ndef(\krm1_a, {~tremoloL1amp.linlin(1, 16, 0.01, 1)}); }; //amp
    Ndef(\krm1_d, {~tremoloH1.linlin(1, 16, 1, 40)}); // decay


// snippet 2
    Ndef(\krm2_1, {~tremoloM2.linlin(1, 16, 180, 800)}); // pitch
    Ndef(\krm2_2, {~tremoloL2.linlin(1, 16, 0, 1.5)}); // amp
    Ndef(\krm2_3, {~tremoloH2.linlin(1, 16, 0, 15)}); // fx

// tempo

	// if (~t != ~t) {
	// Tdef(\tempochange, {
	// 	var frame = Array.fill()
	// 	t.tempo = ~t;
	//
	// 	}).play;
	// }

    0.08.wait;
    }
}).play(~ts);

s.sync;
"mottipets ready!...".postln;
});
/// CODE SPACE:
