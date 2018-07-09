// CodeKlavier Environment

// tempo by default
t=TempoClock.default;

// load Huygens sample
~path = thisProcess.nowExecutingPath.dirname;
~hugbuf = Buffer.read(s, ~path++"/Samples/huygens.wav");
~hugbuf2 = Buffer.read(s, ~path++"/Samples/huygens2.wav");

"Huygens samples loaded...".postln;

(~path++"/quotes.scd").load;

~stop = Environment[
'now' -> {|self|
"stopping".postln;
~hello.stop;
~hello2.stop;
~hello3.stop;
~clock.stop;
~clock2.stop;
~clock3.stop;
~ost.stop;
~ost1.stop;
~ost2.stop;
~down=0;~down1=0;~down2=0;
~op=0;~op1=0;~op2=0;
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
'stuk' -> {|self, chunk|
Ndef(~names.next, {FreeVerb.ar(2.5*PlayBuf.ar(2, ~hugbuf, rate: [1, -1].choose, startPos: BufFrames.kr(~hugbuf)*(chunk/90)).sum*EnvGen.kr(Env.perc(0.1, ~sustain)), 0.5, 0.95)}).play([0,1].choose,1);
~sustain = ~sustain*1.1;
},
'end' -> {|self|
    Ndef.all.do{|n| n.stop(13.rrand(15))};
    //Ndef(\huyg, {FreeVerb.ar(FreqShift.ar(PlayBuf.ar(2, ~hugbuf2, startPos: 0).sum, LFNoise1.kr([4, 1]).range(-10, 10)*Line.kr(1,0,6)), Line.kr(1, 0.1, 20), 1)}).play([0,1].choose,1);
    //~snippet2.stop;
    //~snippet1.stop;
    ~stop.now;
}
];

~gong = Environment[
'play' -> {|self, freq_offset|
Ndef(\gong, {0.2*FreeVerb.ar(Splay.ar(WhiteNoise.ar(Impulse.kr(0.2))+SinOsc.ar([(1234+freq_offset)*LFTri.kr(0.1.rrand(18)).range(0.98, 1.02), 150, 299, 544*Line.kr(1, 2, 6), 1789]))*EnvGen.kr(Env.perc), 0.5, 0.95)}).play;
}
];

// images dictionary:
		i = ();
		i[0] = Image.new(~path++"/images/1.png");
		i[1] = Image.new(~path++"/images/2.png");
		// i[2] = Image.new(~path++"/images/3.png");
		i[2] = Image.new(~path++"/images/4.png");

~slider = Pseq(i.atAll(i.order), inf).asStream;


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
	'new' -> {v.clearDrawing;}
];


~img.know = true;
~stop.know = true;
~huygens.know = true;
~gong.know = true;

// hidden gong evaluation:
OSCdef(\ck_gong, {|msg, time, addr, recvPort|
var freq_offset = msg[1].asFloat;
Ndef(\gong, {0.6*FreeVerb.ar(Splay.ar(WhiteNoise.ar(Impulse.kr(0.2))+SinOsc.ar([(1234+freq_offset)*LFTri.kr(0.1.rrand(18)).range(0.98, 1.02), 150, 299, 544*Line.kr(1, 2, 6), 1789])).sum*EnvGen.kr(Env.perc), 0.5, 0.95)}).play;
}, "/gong");

OSCdef(\ck_huyg, {|msg, time, addr, recvPort|
var chunk = msg[1].asFloat;
Ndef(~names.next, {FreeVerb.ar(2.5*PlayBuf.ar(2, ~hugbuf, rate: [1, -1].choose, startPos: BufFrames.kr(~hugbuf)*(chunk/90)).sum*EnvGen.kr(Env.perc(0.1, ~sustain)), 0.5, 0.95)}).play([0,1].choose,1);
~sustain = ~sustain*1.1;
}, "/huygens");

OSCdef(\ck_presenter, {|msg, time, addr, recvPort|
    msg.postln;
    if (msg[1] == 'text1') {
	{~text.string_("You passed bravo!").font_(Font("Courier New", 89)).align_(\center).stringColor_(Color.cyan).background_(Color.new(0,0,0,0.5));}.defer;
        };

	if (msg[1] == 'quote') {
    {~text.string_(~quotes.next).font_(Font("Courier New", 39)).align_(\center).stringColor_(Color.cyan).background_(Color.new(0,0,0,0.5));}.defer;
    };

}, "/ck_pp");
