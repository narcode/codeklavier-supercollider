// CodeKlavier Environment

// Misc checks:
if (thisProcess.openUDPPort(57120)) {
"UDP port for CodeKlavier is correct and listening...".postln;
} {
"Error opening UDP port for communication with CK!".warn;
};

// tempo by default
t=TempoClock.default;

// load Huygens sample
~path = thisProcess.nowExecutingPath.dirname;
~hugbuf = Buffer.read(s, ~path++"/Samples/huygens.wav");
~hugbuf2 = Buffer.read(s, ~path++"/Samples/huygens2.wav");

// global amp variables:
~ampg = 1.5;
~amph = 5;
~ampoffsetg = 0.5;
~ampdong = 0.5;

"Huygens samples loaded...".postln;

// load quotes:
(~path++"/quotes.scd").load;

~stop = Environment[
'all' -> {|self|
"stopping".postln;
~tpiano.stop;
~tpiano2.stop;
~tpiano3.stop;
~piano.stop;
~piano2.stop;
~piano3.stop;
~clock.stop;
~clock2.stop;
~clock3.stop;
~organ.stop;
~organ2.stop;
~organ3.stop;
~ost.stop;
~ost2.stop;
~ost3.stop;
~down1=0;~down2=0;~down3=0;
~op1=0;~op2=0;~op3=0;
t.tempo = 1;
(~path ++ "/snippets.scd").load;
(~path ++ "/CK_environment.scd").load;
{
1.wait;
SkipJack.stopAll;
"pedal watch stopped".postln;
}.fork;
}
];

~sustain = 0.5;
~names = Pseq([\huyg1, \huyg2, \huyg3, \huyg4], inf).asStream;

~huygens = Environment[
'stuk' -> {|self, chunk=321|
Ndef(~names.next, {FreeVerb.ar(2.8*PlayBuf.ar(2, ~hugbuf, rate: [1, -1].choose, startPos: BufFrames.kr(~hugbuf)*(chunk/90)).sum*EnvGen.kr(Env.perc(0.1, ~sustain)), 0.5, 0.95)}).play([0,1].choose,1);
~sustain = ~sustain*1.1;
},
'end' -> {|self|
    Ndef.all.do{|n| n.stop(13.rrand(15))};
    //Ndef(\huygens_eind, {FreeVerb.ar(FreqShift.ar(PlayBuf.ar(2, ~hugbuf2, startPos: 0).sum, LFNoise1.kr([4, 1]).range(-10, 10)*Line.kr(1,0,6)), Line.kr(1, 0.1, 20), 1)}).play([0,1].choose,1);
    //~snippet2.stop;
    //~snippet1.stop;
    ~stop.all;
},
'eind' -> {|self|
    Ndef.all.do{|n| n.stop(13.rrand(15))};
    Ndef(\huygens_eind, {FreeVerb.ar(FreqShift.ar(PlayBuf.ar(2, ~hugbuf2, startPos: 0).sum, LFNoise1.kr([4, 1]).range(-10, 10)*Line.kr(1,0,6)), Line.kr(1, 0.1, 20), 1)}).play([0,1].choose,1);
    //~snippet2.stop;
    //~snippet1.stop;
    ~stop.all;
}
];

~gong = Environment[
'play' -> {|self, freq_offset=123|
Ndef(\gong, {0.9*FreeVerb.ar(Splay.ar(WhiteNoise.ar(Impulse.kr(0.2))+SinOsc.ar([(1234+freq_offset)*LFTri.kr(0.1.rrand(18)).range(0.98, 1.02), 150, 299, 544*Line.kr(1, 2, 6), 1789]))*EnvGen.kr(Env.perc), 0.5, 0.95)}).play;
}
];


// images dictionary:
		~imges = ();
		~imges[0] = Image.new(~path++"/images/1.png");
		// ~imges[1] = Image.new(~path++"/images/5.png");

~slider = Pseq(~imges.atAll(~imges.order), inf).asStream;


~img = Environment[
'load' -> {|name, height, width|
		// graphics:
		~px = 0; ~py = 0; ~pthick=1; ~blue=0;
        ~px1 = 0; ~py1 = 0; ~red=0;
		~image = ~slider.next;
        if (~imgcont != nil) {~imgcont.close};
        if (~image.width > 1000) {~offset = -200;} {~offset=0};
		~imgcont = Window.new("ck presenter",[500+~offset, 391, ~image.width, ~image.height]);
		v = UserView(~imgcont, ~imgcont.view.bounds).clearOnRefresh_(false);
		~imgcont.view.backgroundImage_(~image).alwaysOnTop_(true);
		~text = StaticText(~imgcont, ~imgcont.bounds.width@~imgcont.bounds.height);

   ~snake = {|coordx=0, coordy=0, coordx2=0, coordy2=0, thick=1, color=0, color2=0|
			v.drawFunc = {
				~p1 = Pen;
				~p1.moveTo(Point(~px , ~py));
				~p1.width = ~pthick;
		        ~p1.strokeColor = Color.new(0.0, 1.0, ~blue);
                ~p1.lineTo(Point(coordx, coordy));
		        ~px = coordx; ~py = coordy; ~pthick=thick; ~blue=color;
				~p1.stroke;

				~p2 = Pen;
				~p2.moveTo(Point(~px1 , ~py1));
				~p2.width = ~pthick;
		        ~p2.strokeColor = Color.new(~red, 0.0, 1.0);
                ~p2.lineTo(Point(coordx2, coordy2));
                ~px1 = coordx2; ~py1 = coordy2; ~red=color2;
				~p2.stroke;

		}; v.animate_(true)}.defer;

		~imgcont.front;

		("open -a Atom").unixCmd;

        // presenter:
        (~path ++ "/pythonnets.scd").load;
},
	'new' -> {v.clearDrawing;},
'close' -> {~imgcont.close}
];


~img.know = true;
~stop.know = true;
~huygens.know = true;
~gong.know = true;
~piano_gong = [23, 42, 35, 56, 67, 63, 81, 91, 100, 103];

// hidden gong evaluation:
OSCdef(\ck_gong, {|msg, time, addr, recvPort|
var freq_offset = msg[1].asFloat;
Ndef(\gong, {(~ampg*~ampoffsetg)*FreeVerb.ar(Splay.ar(WhiteNoise.ar(Impulse.kr(0.2))+SinOsc.ar([(1234+freq_offset)*LFTri.kr(0.1.rrand(18)).range(0.98, 1.02), 150, 299, 544*Line.kr(1, 2, 6), 1789])).sum*EnvGen.kr(Env.perc), 0.5, 0.95)}).play([0,1].choose);
}, '/gong');

// disklavier specific
~velocity_offset = 15;
OSCdef(\ck_pianogong, {|msg, time, addr, recvPort|
{
~piano_gong.do{|n| if (n > 80) {~velocitypg = ~ampdong*(40+~velocity_offset)} {~velocitypg = ~ampdong*(30+~velocity_offset)}; ~midi.noteOn(0, n, ~velocitypg)};
3.wait;
~piano_gong.do{|n| ~midi.noteOff(0, n, 100)};
}.fork;
}, '/pianogong');

~grow = Pseq(Array.series(32, 1, 1), inf).asStream;
~max = Pseq(Array.series(32, 109-32, 1), inf).asStream;
~duration = Pseq(Array.series(6/0.1, 0.1, 0.1), inf).asStream;
OSCdef(\ck_piantake, {|msg, time, addr, recvPort|
    {
    ~pianocluster = Array.rand(~grow.next, 21, ~max.next);
    ~pianocluster.do{|n| if (n > 80) {~velocitypg = 40+~velocity_offset} {~velocitypg = 30+~velocity_offset}; ~midi.noteOn(0, n, ~velocitypg)};
    (~duration.next).wait;
    ~pianocluster.do{|n| ~midi.noteOff(0, n, 100)};
    }.fork;
}, '/pianotake');

OSCdef(\ck_huyg, {|msg, time, addr, recvPort|
var chunk = msg[1].asFloat;
Ndef(~names.next, {FreeVerb.ar(~amph*PlayBuf.ar(2, ~hugbuf, rate: [1, -1].choose, startPos: BufFrames.kr(~hugbuf)*(chunk/90)).sum*EnvGen.kr(Env.perc(0.1, ~sustain)), 0.5, 0.95)}).play([0,1].choose,1);
~sustain = ~sustain*1.1;
}, '/huygens');

OSCdef(\ck_pianostop, {|msg, time, addr, recvPort|
if (msg[1] == 'stop123') {
    ~piano.stop; ~piano2.stop; ~piano3.stop;
    };
if (msg[1] == 'stop12') {
    ~piano.stop; ~piano2.stop;
    };
if (msg[1] == 'stop1') {
    ~piano.stop;
    };
}, '/pianostop');

// OSCdef(\ck_presenter, {|msg, time, addr, recvPort|
//     msg.postln;
//     if (msg[1] == 'text1') {
// 	{~text.string_("You passed bravo!").font_(Font("Courier New", 89)).align_(\center).stringColor_(Color.cyan).background_(Color.new(0,0,0,0.5));}.defer;
//         };
//
// 	if (msg[1] == 'quote') {
//     {~text.string_(~squotes.next).font_(Font("Courier New", 39)).align_(\center).stringColor_(Color.cyan).background_(Color.new(0,0,0,0.5));}.defer;
//     };
//
// }, "/ck_pp");
