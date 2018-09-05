/*

snippets for Mottipets

*/
s.waitForBoot({
	"starting server...".postln;

	~ts = TempoClock.new();
	~ts.tempo = 20/60;

~tremoloL1 = 0;
~tremoloL2 = 0;
~tremoloL1amp = 0;
~tremoloM1 = 16;
~tremoloM2 = 16;
~tremoloH1 = 0;
~tremoloH2 = 0;


~mapy = 0;
~mapx = 0;
~mapthickness = 0;
~mapcolor = 0;
~mapy2 = 0;
~mapx2 = 0;
~mapcolor2 = 0;
s.sync;

//loop listener? is there a better solution?
Tdef(\listenerkr_snakes, {
  loop{

{~snake.value(~tremoloL1.linlin(0, 16, 0, ~image.width), ~tremoloM1.linlin(0, 16, ~image.height, 0), ~tremoloL2.linlin(0, 16, 0, ~image.width), ~tremoloM2.linlin(0, 16, ~image.height,0), ~tremoloL1amp.linlin(1, 16, 40, 180), ~tremoloH1.linlin(1, 14, 0.0, 1.0), ~tremoloH2.linlin(1, 14, 0.0, 1.0));}.defer;

    0.05.wait;
    }
}).play(~ts);

s.sync;
"snakes ready!...".postln;
});
/// CODE SPACE:
