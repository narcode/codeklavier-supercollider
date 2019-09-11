// midi mappings:
{
s.waitForBoot({
"starting MIDI...".postln;
MIDIClient.init;
s.sync;
}.fork);
3.wait;
"connecting MIDI interfaces...".postln;
MIDIIn.connectAll;
s.sync;
~midisampler = MIDIOut.newByName("IAC Driver", "Bus 1"); // choose the correct MIDI device
//~midi = MIDIOut.newByName("Clavinova", "Clavinova"); // choose the correct MIDI device
~midi = MIDIOut.newByName("USB MIDI Interface", "USB MIDI Interface"); // choose the correct MIDI device
//~midi = MIDIOut.newByName("YAMAHA USB Device", "Port1"); // choose the correct MIDI device
s.sync;
2.wait;
//hello world
"setting variables and ostinatos...".postln;
~pitch = 0;~pitch1 = 0;~pitch2 = 0; ~pulsepitch = 0;
// adjust the quant;
~quant=1/6;
s.sync;
// ostinatos:
~ost=Pdef(\ostinato1, {Pbind(\legato, 0.1, \amp, Pfunc{~ostamp}, \dur, Pseq([Pfuncn({1/a}, 1), Pfuncn({1/b},1), Pfuncn({1/c},1)], inf), \ctranspose, Pfunc{~pitch},
\midinote, Pseq(["d3".namemidi, "eb3".namemidi,
"B4".namemidi, "f#3".namemidi,
"g#3".namemidi, "a3".namemidi], inf),
\type, \midi, \midiout, Pfunc{~midi}, \chan, 0)});
~ost.quant=~quant;
~ost2=Pdef(\ostinato2, {Pbind(\legato, 0.1, \amp, Pfunc{~ostamp}, \dur, Pseq([Pfuncn({1/g}, 1), Pfuncn({1/h},1), Pfuncn({1/i},1)], inf), \ctranspose, Pfunc{~pitch1},
\midinote, Pseq(["eb3".namemidi, "f3".namemidi,
"C#3".namemidi, "g3".namemidi,
"g#3".namemidi, "a#3".namemidi], inf),
\type, \midi, \midiout, Pfunc{~midi}, \chan, 0)});
~ost2.quant=~quant;
~ost3=Pdef(\ostinato3, {Pbind(\legato, 0.1, \amp, Pfunc{~ostamp}, \dur, Pseq([Pfuncn({1/k}, 1), Pfuncn({1/l},1), Pfuncn({1/m},1)], inf), \ctranspose, Pfunc{~pitch2},
\midinote, Pseq(["d3".namemidi, "f3".namemidi,
"g3".namemidi, "a3".namemidi,
"c3".namemidi, "d4".namemidi], inf),
\type, \midi, \midiout, Pfunc{~midi}, \chan, 0)});
~ost3.quant=~quant;
s.sync;
// random ostinatos

~rand=Tdef(\randostinato, {
var rit = (1/2).rrand(4).round(0.5);
var rit2 = (1/2).rrand(4).round(0.5);
var rit3 = (1/2).rrand(4).round(0.5);
var randrit = [Pfuncn({1/(h*rit)}, 1), Pfuncn({1/(e*rit2)},1), Pfuncn({1/(l*rit3)},1)];
var randpitch = ["ab3".namemidi, "B3".namemidi, "C4".namemidi, "gb3".namemidi, "f3".namemidi, "db3".namemidi].scramble;
	Pdef(\ostinato1, {Pbind(\dur, Pseq(randrit, inf);, \ctranspose, Pfunc{~pitch},
\midinote, Pseq(randpitch, inf),
\type, \midi, \midiout, Pfunc{~midi})})});
s.sync;
//clocks
~clock=Pdef(\clock, {Pbind(\dur, Pseq([Pfunc{~cld1}], inf), \ctranspose, Pfunc{1}, \midinote, Pseq(["c5".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 0)});
~clock.quant=~quant;
~clock2=Pdef(\clock2, {Pbind(\dur, Pseq([Pfunc{~cld2}], inf), \ctranspose, Pfunc{1}, \midinote, Pseq(["c#5".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 0)});
~clock2.quant=~quant;
~clock3=Pdef(\clock3, {Pbind(\dur, Pseq([Pfunc{~cld3}], inf), \ctranspose, Pfunc{1}, \midinote, Pseq(["d5".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 0)});
~clock3.quant=~quant;
~cld1=~cld2=~cld3=2;
// pno
~piano=Pdef(\pno, {Pbind(\amp, Pfunc{~pnoamp}, \legato, 0.1, \dur, Pseq([Pfunc{~pnod1}], inf), \ctranspose, Pfunc{~pno1}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, Pfunc{~midi}, \chan, 0)});
~piano.quant=~quant;
~piano2=Pdef(\pno2, {Pbind(\amp, Pfunc{~pnoamp}, \legato, 0.1, \dur, Pseq([Pfunc{~pnod2}], inf), \ctranspose, Pfunc{~pno2}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, Pfunc{~midi}, \chan, 0)});
~piano2.quant=~quant;
~piano3=Pdef(\pno3, {Pbind(\amp, Pfunc{~pnoamp}, \legato, 0.1, \dur, Pseq([Pfunc{~pnod3}], inf), \ctranspose, Pfunc{~pno3}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, Pfunc{~midi}, \chan, 0)});
~piano3.quant=~quant;
~pnod1=~pnod2=~pnod3=2;
~pno1=~pno2=~pno3=0;
// hello pulse
~tpiano=Pdef(\hello, {Pbind(\dur, Pseq([Pfunc{~tpd1}], inf), \ctranspose, Pfunc{~tp1}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 3)});
~tpiano.quant=~quant;
~tpiano2=Pdef(\hello2, {Pbind(\dur, Pseq([Pfunc{~tpd2}], inf), \ctranspose, Pfunc{~tp2}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 1)});
~tpiano2.quant=~quant;
~tpiano3=Pdef(\hello3, {Pbind(\dur, Pseq([Pfunc{~tpd3}], inf), \ctranspose, Pfunc{~tp3}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 2)});
~tpiano3.quant=~quant;
s.sync;
~tpd1=~tpd2=~tpd3=2;
~tp1=~tp2=~tp3=0;
s.sync;
// organ instances:
~organ=Pdef(\organ, {Pbind(\dur, Pseq([Pfunc{~od1}], inf), \ctranspose, Pfunc{~o1}, \midinote, Pseq(["g#1".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 5)});
~organ.quant=~quant;
~organ2=Pdef(\organ2, {Pbind(\dur, Pseq([Pfunc{~od2}], inf), \ctranspose, Pfunc{~o2}, \midinote, Pseq(["g#1".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 6)});
~organ2.quant=~quant;
~organ3=Pdef(\organ3, {Pbind(\dur, Pseq([Pfunc{~od3}], inf), \ctranspose, Pfunc{~o3}, \midinote, Pseq(["g#1".namemidi], inf), \type, \midi, \midiout, Pfunc{~midisampler}, \chan, 7)});
~organ3.quant=~quant;
s.sync;
// transpose vars:
~od1=~od2=~od3=2;
~o1=~o2=~o3=0;
s.sync;
a=b=c=g=h=i=k=l=m=2;
s.sync;
~reset = Tdef(\reset, {1.do{
	a=b=c=g=h=i=k=l=m=1; t.tempo=1;
	~eamp=0;~eamp2=0;~eamp3=0;
	~pnod1=~pnod2=~pnod3=2;
	~pno1=~pno2=~pno3=0;
	~od1=~od2=~od3=2;
	~del=1;~del2=1;~del3=3;
	~cld1=~cld2=~cld3=2;
	~r3=1;
	~tp1=~tp2=~tp3=0;
	~ost=Pdef(\ostinato1, {Pbind(\legato, 0.1, \amp, Pfunc{~ostamp}, \dur, Pseq([Pfuncn({1/a}, 1), Pfuncn({1/b},1), Pfuncn({1/c},1)], inf), \ctranspose, Pfunc{~pitch},
	\midinote, Pseq(["d3".namemidi, "eb3".namemidi,
	"B4".namemidi, "f#3".namemidi,
	"g#3".namemidi, "a3".namemidi], inf),
	\type, \midi, \midiout, Pfunc{~midi}, \chan, 4)});
	~ost2=Pdef(\ostinato2, {Pbind(\legato, 0.1, \amp, Pfunc{~ostamp}, \dur, Pseq([Pfuncn({1/g}, 1), Pfuncn({1/h},1), Pfuncn({1/i},1)], inf), \ctranspose, Pfunc{~pitch1},
	\midinote, Pseq(["eb3".namemidi, "f3".namemidi,
	"C#3".namemidi, "g3".namemidi,
	"g#3".namemidi, "a#3".namemidi], inf),
	\type, \midi, \midiout, Pfunc{~midi}, \chan, 4)});
	~ost3=Pdef(\ostinato3, {Pbind(\legato, 0.1, \amp, Pfunc{~ostamp}, \dur, Pseq([Pfuncn({1/k}, 1), Pfuncn({1/l},1), Pfuncn({1/m},1)], inf), \ctranspose, Pfunc{~pitch2},
	\midinote, Pseq(["f3".namemidi, "f3".namemidi,
	"B3".namemidi, "f3".namemidi,
	"a3".namemidi, "g3".namemidi], inf),
	\type, \midi, \midiout, Pfunc{~midi}, \chan, 4)});
		}
	});
	s.sync;
"variables for SHA fx".postln;
~eamp=0;~eamp2=0;~eamp3=0;
~del=1;~del2=1;~del3=3;
~r3=1;
	"variables for no CC Pedal".postln;
	~semitonesup = Pseq([1,2,3,4,5,6,7,8,9,10,9,8,7,6,5,4,3,2,1,0], inf).asStream;
	~semitonesd = Pseq([1,2,3,4,5,4,3,2,1,0]*(-1), inf).asStream;

	"starting routine for re-pitching with piano pedal...".postln;
		/// re-pitching:
	SkipJack({
		/*var key = "narcode".scramble;
	Tdef(key.asSymbol, {*/
	Tdef(\maps1, {
		inf.do{
			/*"debug".postln;*/
		Ndef(\fx).map(\del, Ndef(\krd, ~del));
		Ndef(\fx).map(\amp, Ndef(\kra, ~eamp));

		Ndef(\fx1).map(\del, Ndef(\krd2, ~del2));
		Ndef(\fx1).map(\amp, Ndef(\kra2, ~eamp2));

		Ndef(\fx2).map(\del, Ndef(\krd3, ~del3));
		Ndef(\fx2).map(\amp, Ndef(\kra3, ~eamp3));
		Ndef(\fx2).map(\rate, Ndef(\krr3, ~r3));
	0.1.wait;
	}
		}).play;


		1.do {

		if (~op1 == 1) {
			/*("op ---> running").postln;*/

			MIDIdef.cc(\pedalpitchop, {arg ...args;
				// args.postln;
				if (args[1] == 64) {
					~pitch = args[0].linlin(0, 127, 0, 52).round(1);
					("ostinato1 ***" + ~pitch + " semitones up").postln;
				}
			});
		};

		if (~op1 == 0) {
			/*("op ----> stopped").postln;*/
	MIDIdef.cc(\pedalpitchop).free;
		};

		if (~op2 == 1) {
			MIDIdef.cc(\pedalpitchop1, {arg ...args;
				// args.postln;
				if (args[1] == 64) {
					~pitch1 = args[0].linlin(0, 127, 0, 52).round(1);
				  ("ostinato2 ***" + ~pitch1 + " semitones up").postln;
				}
			});
		};

		if (~op2 == 0) {
	MIDIdef.cc(\pedalpitchop1).free;
		};

		if (~op3 == 1) {
			MIDIdef.cc(\pedalpitchop2, {arg ...args;
				// args.postln;
				if (args[1] == 64) {
					~pitch2 = args[0].linlin(0, 127, 0, 52).round(1);
					("ostinato3 *** " + ~pitch2 + " semitones up").postln;
				}
			});
		};

		if (~op3 == 0) {
	MIDIdef.cc(\pedalpitchop2).free;
		};

		if (~down1 == 1) {
			// ("down ---> running").postln;
			MIDIdef.cc(\pedalpitchd, {arg ...args;
				if (args[1] == 64) {
					~pitch = args[0].linlin(0, 127, 0, -52).round(1);
					("ostinato1 ***" + ~pitch + " semitones down").postln;
				}
			});
		};

		if (~down1 == 0) {
			/*("down ----> stopped").postln;*/

	MIDIdef.cc(\pedalpitchd).free;
		};

		if (~down2 == 1) {
			MIDIdef.cc(\pedalpitchd1, {arg ...args;
				if (args[1] == 64) {
					~pitch1 = args[0].linlin(0, 127, 0, -52).round(1);
				  ("ostinato2 ***" + ~pitch1 + " semitones down").postln;
				}
			});
		};

		if (~down2 == 0) {
	MIDIdef.cc(\pedalpitchd1).free;
		};

		if (~down3 == 1) {
			MIDIdef.cc(\pedalpitchd2, {arg ...args;
				if (args[1] == 64) {
					~pitch2 = args[0].linlin(0, 127, 0, -52).round(1);
					("ostinato3 ***" + ~pitch2 + " semitones down").postln;
				}
			});
		};

		if (~down3 == 0) {
	MIDIdef.cc(\pedalpitchd2).free;
		};
	}; }, 0.2, name: "pedalwatch");
	s.sync;
	"CodeKlavier is ready and listening...".postln;
}.fork;

/*
if you want to stop the pedal watcher:

SkipJack.stop("pedalwatch");

*/
