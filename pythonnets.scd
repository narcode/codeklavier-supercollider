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

{~snake.value(~tremoloL1.linlin(0, 16, 0, ~image.width), ~tremoloM1.linlin(0, 16, 0, ~image.height), ~tremoloL2.linlin(0, 16, 0, ~image.width), ~tremoloM2.linlin(0, 16, 0, ~image.height), ~tremoloL1amp.linlin(1, 16, 1, 36), ~tremoloH1.linlin(1, 14, 0.0, 1.0), ~tremoloH2.linlin(1, 14, 0.0, 1.0));}.defer;

// snake 1
			//
			// if (~mapx == 1 && ~mapy == 0) {
			// 	"snake 1 x only ".postln;
			// 	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~py, ~px1, ~py1, ~pthick, ~blue, ~red);}.defer;
			// }; // x
			//
			// if (~mapx == 0 && ~mapy == 1) {
			// 	"snake 1 y only".postln;
			// 	{~snake.value(~px, ~tremoloM1.linlin(0, 16, 0, 700), ~px1, ~py1, ~pthick, ~blue, ~red);}.defer;
			// }; // x
			//
			// if (~mapy == 1 && ~mapx == 1) {
			// 	"snake 1 x & y".postln;
			// 	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~tremoloM1.linlin(0, 16, 0, 700), ~px1, ~py1, ~pthick, ~blue, ~red);}.defer;
			// }; // x & y
			//
			// if (~mapy == 1 && ~mapx == 1 && ~mapcolor == 1) {
			// 	"snake 1 x & y plus color".postln;
			// 	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~tremoloM1.linlin(0, 16, 0, 700), ~px1, ~py1, ~pthick, ~tremoloH1.linlin(0, 16, 0.0, 1.0), ~red);}.defer;
			// }; // with color
			//
			// if ((~mapy == 0 || ~mapx == 1) && ~mapcolor == 1) {
			// 	"snake 1 x plus color".postln;
			// 	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~tremoloM1.linlin(0, 16, 0, 700), ~px1, ~py1, ~pthick, ~tremoloH1.linlin(0, 16, 0.0, 1.0), ~red);}.defer;
			// }; // with color
			//
			// if (~mapthickness == 1) {
			// 	"snake 1 x & y plus thickness".postln;
			// 	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~tremoloM1.linlin(0, 16, 0, 700), ~px1, ~py1, ~tremoloL1amp.linlin(1, 16, 1, 36), ~blue, ~red);}.defer;
			// }; //amp
			//
			// // snippet 2
			// if (~mapy2 == 1 && ~mapx2 == 1) {
			// 	"snake 2 x & y".postln;
			// 	{~snake.value(~px, ~py, ~tremoloL2.linlin(0, 16, 0, 795), ~tremoloM2.linlin(0, 16, 0, 587), ~pthick, ~blue, ~red);}.defer;
			// }; // X AND Y
			//
			// if (~mapy2 == 0 && ~mapx2 == 1) {
			// 	"snake 2 x only".postln;
			// 	{~snake.value(~px, ~py ~tremoloL2.linlin(0, 16, 0, 795), ~py1, ~pthick, ~blue, ~red);}.defer;
			// }; // X
			//
			// if (~mapy2 == 0 && ~mapx2 == 1) {
			// 	"snake 2 y only".postln;
			// 	{~snake.value(~px, ~py, ~px1, ~tremoloM2.linlin(0, 16, 0, 700), ~pthick, ~blue, ~red);}.defer;
			// }; // X
			//
			// // if (~mapy2 == 1 && ~mapx2 == 1 && ~mapcolor2 == 1) {
			// // "snake 2 x & y + color".postln;
			// // {~snake2.value(~px1, ~py1, ~pthick, ~tremoloH2.linlin(0, 16, 0.0, 1.0));}.defer;
			// // }; //amp
			//
			// if (((~mapy2 == 0 || ~mapy2 == 1) && (~mapx2 == 0 || ~mapx2 == 1)) && ~mapcolor2 == 1) {
			// 	"snake 2 x & y and color".postln;
			// 	{~snake.value(~px, ~py, ~tremoloL2.linlin(0, 16, 0, 700), ~tremoloM2.linlin(0, 16, 0, 700), ~pthick, ~blue, ~tremoloH2.linlin(0, 16, 0.0, 1.0));}.defer;
			// }; //amp

    0.1.wait;
    }
}).play(~ts);

s.sync;
"snakes ready!...".postln;
});
/// CODE SPACE:
