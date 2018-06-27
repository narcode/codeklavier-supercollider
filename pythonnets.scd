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
~tremoloL2 = 5;
~tremoloL1amp = 1;
~tremoloM1 = 10;
~tremoloM2 = 1;
~tremoloH1 = 1;
~tremoloH2 = 5;

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

if (~mapx == true && ~mapy == false) {
"1".postln;
{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~py, ~pthick, ~blue);}.defer;
}; // x

if (~mapx == false && ~mapy == true) {
"2".postln;
{~snake.value(~px, ~tremoloM1.linlin(0, 16, 0, 587), ~pthick, ~blue);}.defer;
}; // x

	if (~mapy == true && ~mapx == true) {
"3".postln;
	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~tremoloM1.linlin(0, 16, 0, 587), ~pthick, ~blue);}.defer;
 	}; // x & y

	if (~mapy == true && ~mapx == true && ~mapcolor == true) {
"4".postln;
	{~snake.value(~tremoloL1.linlin(0, 16, 0, 795), ~tremoloM1.linlin(0, 16, 0, 587), ~pthick, ~tremoloH1.linlin(0, 16, 0.0, 1.0));}.defer;
 	}; // with color

	if (~mapthickness == true) {
"5".postln;
		{~snake.value(~px, ~py, ~tremoloL1amp.linlin(1, 16, 1, 36), ~blue);}.defer;
  	}; //amp

// snippet 2
// if (~mapx2 == true && ~mapy2 == false) {
// "6".postln;
// {~snake2.value(~tremoloL2.linlin(0, 16, 0, 795), ~py1, ~pthick, ~red);}.defer;
// }; // x
//
// if (~mapx2 == false && ~mapy2 == true) {
// "7".postln;
// {~snake2.value(~px1, ~tremoloM2.linlin(0, 16, 0, 587), ~pthick, ~red);}.defer;
// }; // x


if (~mapy2 == true && ~mapx2 == true) {
"8".postln;
{~snake2.value(~tremoloL2.linlin(0, 16, 0, 795), ~tremoloM2.linlin(0, 16, 0, 587), ~pthick, ~red);}.defer;
}; // rit

if (~mapy2 == true && ~mapx2 == true && ~mapcolor2 == true) {
"9".postln;
{~snake2.value(~px1, ~py1, ~pthick, ~tremoloH2.linlin(0, 16, 0.0, 1.0));}.defer;
}; //amp

    0.1.wait;
    }
}).play(~ts);

s.sync;
"snakes ready!...".postln;
});
/// CODE SPACE:
