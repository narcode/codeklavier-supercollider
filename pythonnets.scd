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
~tremoloM1 = 0;
~tremoloM2 = 0;
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
Tdef(\listenerkr, {
  loop{

{~snake.value(~tremoloL1.linlin(0, 16, 0, ~image.width), ~tremoloM1.linlin(0, 16, 0, ~image.height), ~tremoloL2.linlin(0, 16, 0, ~image.width), ~tremoloM2.linlin(0, 16, 0, ~image.height), ~tremoloL1amp.linlin(1, 16, 3, 36), ~tremoloH1.linlin(1, 14, 0.0, 1.0), ~tremoloH2.linlin(1, 14, 0.0, 1.0));}.defer;

    0.1.wait;
    }
}).play(~ts);

s.sync;
"snakes ready!...".postln;
});
/// CODE SPACE:
