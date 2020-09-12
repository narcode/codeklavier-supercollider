~view = 1;
~legato = ();
7.do{|l| ~legato[l+1] = 1};
~chn = ();
10.do{|ch| ~chn[ch+1] = ch};

t.tempo_(30/60);

(
OSCdef(\ckar, {arg msg;
var contents = msg[~view].asString.split($,);
var tree = contents[0].findRegexpAt("[0-9]")[0].asInt;
var seq = contents[0].findRegexpAt("[0-9]+", 2);
var shape = contents[0].findRegexp("S.")[0][1].findRegexp("[0-9]")[0][1].asInt;
var gen = contents[0].findRegexp("G.*S")[0][1].findRegexp("[0-9]+")[0][1].asInt;
var leaves = seq[1].asInt;
var offset=36;
var list=[];
var pattern;

	seq = seq[0].findRegexp("[0-9]").flop.at(1).asInt;

	("tree: " ++ tree).postln;
	("contents: " ++ contents).postln;
	("seq: " ++ seq).postln;
	("leaves: " ++ leaves).postln;
	("shape: " ++ shape).postln;
	("gen: " ++ gen).postln;

msg.postln;

pattern = seq.collect{ arg item,index;
	if (item == 0) {
		0;
	} {
			if ((~chn[tree] >= 2) && (~chn[tree] <= 5)) {
				if (gen < 5) {
					item + 35;
				} {
					(item * 2) + 35;
				}

			} {
				(item * gen) + 35;
			}
	}
};

pattern.postln;
("channel: " ++ ~chn[tree]).postln;

Pdef(("fokker_"++~chn[tree]).asSymbol, {Pbind(\dur, Pseq([1/shape], inf), \stepsPerOctave, 31, \midinote, Pseq(pattern, inf), \legato, Pfunc{(1/shape)*~legato[tree]}, \chan, Pfunc{~chn[tree]}, \type, \midi, \midiout, m)}).play;

}, 'ckartree');

OSCdef(\ckar1, {arg msg;
	("VIEW: " + msg[1]).postln;
	~view = msg[1].asInt;
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
		~legato[tree.asInt] = msg[2].linlin(0.06, 1.5, 0.1, 4);
		~legato[tree.asInt].postln;
		}

}, 'ckarvalue');


OSCdef(\ckar2, {arg msg;
			var key = msg[1].asString.split($,);
			var tree = key[0].findRegexpAt("[0-9]+")[0];
			var room = msg[2].linlin(-1, 1, 1, 30);

			msg.postln;
}, 'ckartreetransform');


);