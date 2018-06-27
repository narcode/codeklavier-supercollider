/*

snippets for Mottipets

*/
s.waitForBoot({
	"starting server...".postln;

	~ts = TempoClock.new();
	~ts.tempo = 20/60;

~tremoloM = 1;
~tremoloH = 1;
~tremoloL = 1;
~tremoloL1 = 1;
~tremoloL2 = 1;
~tremoloL1amp = 1;
~tremoloM1 = 1;
~tremoloM2 = 1;
~tremoloH1 = 1;
~tremoloH2 = 1;

~mapy = false;
~mapx = false;
~mapthickness = false;
~mapcolor = false;
~mapy2 = false;
~mapx2 = false;
~mapcolor2 = false;
s.sync;

//loop listener? is there a better solution?
Tdef(\listenerkr, {
  loop{

// snake 1
	if (~mapy == true && ~mapx == true) {
	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~tremoloM1.linlin(0, 16, 0, 587), ~pthick, ~blue);}.defer;
 	}; // rit
	if (~mapthickness == true) {
		{~snake.value(~px, ~py, ~tremoloL1amp, ~blue);}.defer;
  	}; //amp
	if (~mapcolor == true) {
				{~snake.value(~px, ~py, ~pthick, ~tremoloH1.linlin(0, 16, 0.0, 1.0));}.defer;
  	}; //amp


// snippet 2
// if (~mapy2 == true && ~mapx2 == true) {
// {~snake2.value(~tremoloL2.linlin(0, 16, 0, 795), ~tremoloM2.linlin(0, 16, 0, 587), ~pthick2, ~blue2);}.defer;
// }; // rit
//
// // snake 1
// // if (~mapx == true) {
// // 	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~py, ~pthick, ~blue);}.defer;
// // 	}; // rit
// if (~mapcolor2 == true) {
// {~snake2.value(~px, ~py, ~pthick2, ~tremoloH2.linlin(0, 16, 0.0, 1.0));}.defer;
// }; //amp

    0.1.wait;
    }
}).play(~ts);

s.sync;
"snakes ready!...".postln;
});
/// CODE SPACE:
