~view = 1;
~legato = ();
~root = ();
10.do{|l| ~legato[l+1] = 1};
~chn = ();
10.do{|ch| ~chn[ch+1] = ch};

10.do{|t| ~root[t+1] = 0};

t.tempo_(30/60);

(
OSCdef(\ckar, {arg msg;
msg.removeAt(0);
msg.do{|contents, i|
		{
		var tree = contents.asString.findRegexpAt("[0-9]")[0].asInteger;
		var seq = contents.asString.findRegexpAt("[0-9]+", 2);
		var shape = contents.asString.findRegexp("S.")[0][1].findRegexp("[0-9]")[0][1].asInteger;
		var gen = contents.asString.findRegexp("G.*S")[0][1].findRegexp("[0-9]+")[0][1].asInteger;
		var leaves = seq[1].asInteger;
		var offset=36;
		var list=[];
		var pattern;
		var notes = [];
		var subdiv;
		// ("contents in " ++ contents).postln;
		seq = seq[0].findRegexp("[0-9]").flop.at(1).asInteger;
		("******************************").postln;
		("******************************").postln;
		("tree: " ++ tree).postln;
		("contents: " ++ contents).postln;
		("seq: " ++ seq).postln;
		("leaves: " ++ leaves).postln;
		("shape: " ++ shape).postln;
		("gen: " ++ gen).postln;

		pattern = seq.collect{ arg item,index;
			if (item == 0) {
				0;
			} {
				if ((~chn[tree] >= 3) && (~chn[tree] <= 5)) {
					/*				if (gen < 5) {
					item + 35;
					} {*/
					(item + (gen-1)) + 37;
					// }

				} {
					(item*4) + (gen*4) + 35;
				}
			}
		};

		pattern.postln;
		// pattern.collect{|e| notes.add(e.midiname)};
		// notes.postln;

		if (seq.size > 4) {
			subdiv = shape+(seq.size-1).clip(0,8);
		} {
			subdiv = shape;
		};

		("channel: " ++ ~chn[tree]).postln;
		Pdef(("fokker_"++~chn[tree]).asSymbol, {Pbind(\dur, Pseq([1/subdiv], inf), \stepsPerOctave, 31, \midinote, Pseq(pattern, inf), \ctranspose, Pfunc{~root[tree]},\legato, Pfunc{~legato[tree]}, \chan, Pfunc{~chn[tree]}, \type, \midi, \midiout, m)}).play;
		}.fork;
	} // iteration loop
}, 'ckartree');

OSCdef(\ckar1, {arg msg;
	("VIEW: " + msg[1]).postln;
	~view = msg[1].asInteger;
}, 'ckartreeview');


OSCdef(\ckar3, {arg msg;
var key = msg[1].asString.split($,);
var tree = key[0].findRegexpAt("[0-9]+")[0];
var keyval = key[0].findRegexp("[a-z]+")[0][1];

	// key.postln;
	// tree.postln;
	// keyval.postln;
	// msg.postln;

	if (keyval == "speed") {
/*		msg[2].postln;*/
		// ~legato = msg[2].clip(0.1, 4);
		~legato[tree.asInteger] = msg[2].linlin(0.06, 1.5, 0.1, 4);
		~legato[tree.asInteger].postln;
		}

}, 'ckarvalue');


OSCdef(\ckar2, {arg msg;
			var key = msg[1].asString.split($,);
			var tree = key[0].findRegexpAt("[0-9]+")[0];
			var root = msg[2];

	~root[tree.asInteger] = root.asInteger;
			msg.postln;
}, 'ckartreetransform');


);
