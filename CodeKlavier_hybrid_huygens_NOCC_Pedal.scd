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
m = MIDIOut.newByName("IAC Driver", "Bus 1");
s.sync;
2.wait;
//hello world
"setting variables and ostinatos...".postln;
~pitch = 0;~pitch1 = 0;~pitch2 = 0; ~pulsepitch = 0;
// adjust the quant;
~quant=1/16;
s.sync;
// ostinatos:
~ost=Pdef(\ostinato1, {Pbind(\dur, Pseq([Pfuncn({1/h}, 1), Pfuncn({1/e},1), Pfuncn({1/l},1)], inf), \ctranspose, Pfunc{~pitch},
\midinote, Pseq(["d3".namemidi, "B2".namemidi, "g3".namemidi, "a3".namemidi, "g3".namemidi], inf),
\type, \midi, \midiout, m, \chan, 4)});
~ost.quant=~quant;
~ost1=Pdef(\ostinato2, {Pbind(\dur, Pseq([Pfuncn({1/w}, 1), Pfuncn({1/o},1), Pfuncn({1/r},1)], inf), \ctranspose, Pfunc{~pitch1},
\midinote, Pseq(["c#4".namemidi, "d4".namemidi, "a3".namemidi], inf),
\type, \midi, \midiout, m, \chan, 4)});
~ost1.quant=~quant;
~ost2=Pdef(\ostinato3, {Pbind(\dur, Pseq([Pfuncn({1/a}, 1), Pfuncn({1/n},1), Pfuncn({1/d},1)], inf), \ctranspose, Pfunc{~pitch2},
\midinote, Pseq(["d3".namemidi, "B2".namemidi, "g3".namemidi, "g3".namemidi,
"a3".namemidi, "g3".namemidi, "b3".namemidi, "c#4".namemidi, "d4".namemidi, "a3".namemidi,
"b3".namemidi, "a3".namemidi, "g3".namemidi, "f#3".namemidi, "e3".namemidi, "d3".namemidi], inf),
\type, \midi, \midiout, m, \chan, 4)});
~ost2.quant=~quant;
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
\type, \midi, \midiout, m)})});
s.sync;
//clocks
~clock=Pdef(\clock, {Pbind(\dur, Pseq([2], inf), \ctranspose, Pfunc{1}, \midinote, Pseq(["c5".namemidi], inf), \type, \midi, \midiout, m, \chan, 0)});
~clock.quant=~quant;
~clock2=Pdef(\clock2, {Pbind(\dur, Pseq([2], inf), \ctranspose, Pfunc{1}, \midinote, Pseq(["c#5".namemidi], inf), \type, \midi, \midiout, m, \chan, 0)});
~clock2.quant=~quant;
~clock3=Pdef(\clock3, {Pbind(\dur, Pseq([2], inf), \ctranspose, Pfunc{1}, \midinote, Pseq(["d5".namemidi], inf), \type, \midi, \midiout, m, \chan, 0)});
~clock3.quant=~quant;
// hello pulse
~tpiano=Pdef(\hello, {Pbind(\dur, Pseq([Pfunc{~tpd1}], inf), \ctranspose, Pfunc{~tp1}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, m, \chan, 3)});
~tpiano.quant=~quant;
~tpiano2=Pdef(\hello2, {Pbind(\dur, Pseq([Pfunc{~tpd2}], inf), \ctranspose, Pfunc{~tp2}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, m, \chan, 1)});
~tpiano2.quant=~quant;
~tpiano3=Pdef(\hello3, {Pbind(\dur, Pseq([Pfunc{~tpd3}], inf), \ctranspose, Pfunc{~tp3}, \midinote, Pseq(["a2".namemidi], inf), \type, \midi, \midiout, m, \chan, 2)});
~tpiano3.quant=~quant;
s.sync;
~tpd1=~tpd2=~tpd3=2;
~tp1=~tp2=~tp3=0;
s.sync;
// organ instances:
~organ=Pdef(\organ, {Pbind(\dur, Pseq([Pfunc{~od1}], inf), \ctranspose, Pfunc{~o1}, \midinote, Pseq(["g#1".namemidi], inf), \type, \midi, \midiout, m, \chan, 5)});
~organ.quant=~quant;
~organ2=Pdef(\organ2, {Pbind(\dur, Pseq([Pfunc{~od2}], inf), \ctranspose, Pfunc{~o2}, \midinote, Pseq(["g#1".namemidi], inf), \type, \midi, \midiout, m, \chan, 6)});
~organ2.quant=~quant;
~organ3=Pdef(\organ3, {Pbind(\dur, Pseq([Pfunc{~od3}], inf), \ctranspose, Pfunc{~o3}, \midinote, Pseq(["g#1".namemidi], inf), \type, \midi, \midiout, m, \chan, 7)});
~organ3.quant=~quant;
s.sync;
// transpose vars:
~od1=~od2=~od3=2;
~o1=~o2=~o3=0;
s.sync;
h=e=l=o=w=d=a=r=n=1;
s.sync;
~reset = Tdef(\reset, {1.do{h=e=l=o=w=d=a=r=n=1; t.tempo=1;
	~eamp=0;~eamp2=0;~eamp3=0;
	~del=1;~del2=1;~del3=3;
	~r3=1;
	~tp1=~tp2=~tp3=0;
	~ost=Pdef(\ostinato1, {Pbind(\dur, Pseq([Pfuncn({1/h}, 1), Pfuncn({1/e},1), Pfuncn({1/l},1)], inf), \ctranspose, Pfunc{~pitch},
	\midinote, Pseq(["d3".namemidi, "B2".namemidi, "g3".namemidi, "g3".namemidi,
	"a3".namemidi, "g3".namemidi, "b3".namemidi, "c#4".namemidi, "d4".namemidi, "a3".namemidi,
	"b3".namemidi, "a3".namemidi, "g3".namemidi, "f#3".namemidi, "e3".namemidi, "d3".namemidi], inf),
	\type, \midi, \midiout, m, \chan, 4)});
	~ost1=Pdef(\ostinato2, {Pbind(\dur, Pseq([Pfuncn({1/w}, 1), Pfuncn({1/o},1), Pfuncn({1/r},1)], inf), \ctranspose, Pfunc{~pitch1},
	\midinote, Pseq(["d3".namemidi, "B2".namemidi, "g3".namemidi, "g3".namemidi,
	"a3".namemidi, "g3".namemidi, "b3".namemidi, "c#4".namemidi, "d4".namemidi, "a3".namemidi,
	"b3".namemidi, "a3".namemidi, "g3".namemidi, "f#3".namemidi, "e3".namemidi, "d3".namemidi], inf),
	\type, \midi, \midiout, m, \chan, 4)});
	~ost2=Pdef(\ostinato3, {Pbind(\dur, Pseq([Pfuncn({1/a}, 1), Pfuncn({1/n},1), Pfuncn({1/d},1)], inf), \ctranspose, Pfunc{~pitch2},
	\midinote, Pseq(["d3".namemidi, "B2".namemidi, "g3".namemidi, "g3".namemidi,
	"a3".namemidi, "g3".namemidi, "b3".namemidi, "c#4".namemidi, "d4".namemidi, "a3".namemidi,
	"b3".namemidi, "a3".namemidi, "g3".namemidi, "f#3".namemidi, "e3".namemidi, "d3".namemidi], inf),
	\type, \midi, \midiout, m, \chan, 4)});
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

	// pedal:
	MIDIdef.cc(\noCC, {|msg|
		if (msg == 127) {
		~pedalpressed = true;
		} {
		~pedalpressed = false;
		}
	}, 64);

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

		if (~op == 1) {
			/*("op ---> running").postln;*/

			// MIDIdef.cc(\pedalpitch, {arg ...args;
				// if (args[1] == 64 && args[2] == 127) {
					if (~pedalpressed == true) {
					~pitch = ~semitonesup.next;
					("ostinato ***" + ~pitch + " semitones up").postln;
					};
				// }
			// });
		};

		if (~op == 0) {
			/*("op ----> stopped").postln;*/
	// MIDIdef.cc(\pedalpitch).free;
		};

		if (~op1 == 1) {
			// MIDIdef.cc(\pedalpitchop1, {arg ...args;
				// if (args[1] == 64 && args[2] == 127) {
				if (~pedalpressed == true) {
					~pitch1 = ~semitonesup.next;
					("ostinato1 ***" + ~pitch1 + " semitones up").postln;
						};
				// }
			// });
		};

		if (~op1 == 0) {
	// MIDIdef.cc(\pedalpitchop1).free;
	Tdef(\iclcP1).stop;
		};

		if (~op2 == 1) {
			// MIDIdef.cc(\pedalpitchop2, {arg ...args;
				// if (args[1] == 64 && args[2] == 127) {
				if (~pedalpressed == true) {
					~pitch2 = ~semitonesup.next; };
					("ostinato2 ***" + ~pitch2 + " semitones up").postln;

			// 	}
			// });
		};

		if (~op2 == 0) {
	// MIDIdef.cc(\pedalpitchop2).free;
		Tdef(\iclcP2).stop;
		};

		if (~down == 1) {
			// MIDIdef.cc(\pedalpitchd, {arg ...args;
			// 	if (args[1] == 64 && args[2] == 127) {
			if (~pedalpressed == true) {
					~pitch = ~semitonesd.next;
					("ostinato ***" + ~pitch + " semitones down").postln;
				};
			// 	}
			// });
		};

		if (~down == 0) {
			/*("down ----> stopped").postln;*/
	Tdef(\iclcP).stop;
	// MIDIdef.cc(\pedalpitchd).free;
		};

		if (~down1 == 1) {
			// MIDIdef.cc(\pedalpitchd1, {arg ...args;
			// 	if (args[1] == 64 && args[2] == 127) {
			if (~pedalpressed == true) {
					~pitch1 = ~semitonesd.next;
					("ostinato ***" + ~pitch1 + " semitones down").postln;
				};
			// 	}
			// });
		};

		if (~down1 == 0) {
	// MIDIdef.cc(\pedalpitchd1).free;
	Tdef(\iclcP1).stop;
		};

		if (~down2 == 1) {
			// MIDIdef.cc(\pedalpitchd2, {arg ...args;
			// 	if (args[1] == 64 && args[2] == 127) {
			if (~pedalpressed == true) {
					~pitch2 = ~semitonesd.next;
					("ostinato2 ***" + ~pitch2 + " semitones down").postln;
				};
			// 	}
			// });
		};

		if (~down2 == 0) {
	// MIDIdef.cc(\pedalpitchd2).free;
	Tdef(\iclcP2).stop;
		};
	}; }, 0.2, name: "pedalwatch");
	s.sync;
	"CodeKlavier is ready and listening...".postln;
}.fork;

/*
if you want to stop the pedal watcher:

SkipJack.stop("pedalwatch");

*/
