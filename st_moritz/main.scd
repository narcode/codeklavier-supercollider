//// los 7 cículos
Ndef(\rzo2).stop(3);
t.tempo_(74/60);
~ampf = 0.5;
( // check volumes
b = { Synth(\sampleNarcode, [\buf, ~buffers['rabinal'][2], \rl, 1, \rate, 1, \pos, 0, \amp, 0.8, \out, 1])};
a = { Synth(\sampleNarcode, [\buf, ~buffers['rabinal'][8], \rl, 2, \amp, 0.8, \rate, 1, \pos, 0.rrand(0.5), \out, 0])};
c = { Synth(\sampleNarcode, [\buf, ~buffers['trio'][2], \rl, 1, \rate, 1, \pos, 0, \amp, 0.44, \out, 0])};
);
Ndef(\rzo2).stop(9);
~funcs = ();
~funcs['c'] = { m.(c, nil, true, 0, [1], 0, 1).play }; // MX3 --> Q
~funcs['a'] = { m.(b, nil, true, 1, 0, [1], 0).play };
~funcs['b'] = { m.(a, nil, true, 1, 0, 2 , 1).play };

// dev
~funcs['a'] = { m.(b, nil, true, 1, 0, [2], 0).play };
~funcs['b'] = { m.(a, nil, true, 1, [1,1,1], 1 ,[0, 2]).play };
~funcs['c'] = { m.(c, nil, true, 0, 2, 0, 1).play };

// cool to end:
~funcs['a'] = { m.(b, nil, true, 1, 3, [6], 0).play };
~funcs['b'] = { m.(a, nil, true, [2], [4, 2], 3, 2).play };
~funcs['c'] = { m.(c, nil, true, 4, [9, 2], 5, 8).play };

( // check volumes
b = { Synth(\sampleNarcode, [\buf, ~buffers['rabinal'][15], \rl, 1, \rate, 1, \pos, 0, \amp, 1, \out, 1])};
a = { Synth(\sampleNarcode, [\buf, ~buffers['rabinal'][11], \rl, 2, \amp, 1, \rate, 1, \pos, 0.rrand(0.5), \out, 0])};
c = { Synth(\sampleNarcode, [\buf, ~buffers['trio'][0.rrand(5)], \rl, 1, \rate, 1, \pos, 0, \amp, 0.7, \out, 0])};
);

( // los 7 círculos end fadeout
b = { Synth(\sampleNarcode, [\buf, ~buffers['trio_voz'][0], \rl, 1, \rate, 1, \pos, 0, \amp, ~ampf, \out, 0])};
a = { Synth(\sampleNarcode, [\buf, ~buffers['trio_voz'][1], \rl, 1, \rate, 1, \amp, ~ampf, \pos, 0, \out, 1])};
c = { Synth(\sampleNarcode, [\buf, ~buffers['trio_voz'][4], \rl, 1, \rate, 1, \pos, 0, \amp, ~ampf, \out, 0])};
);
~ampf = 5;
r.stop;
~funcs = ();

"say -v vicki samba, samba,  funky, yeah".unixCmd;

// estoy desapareciendo
t.tempo_(86/60);
g = Group.new(s, 'addToHead'); // test
Ndef(\rev, {GVerb.ar(In.ar(60,2), 119, 3)*0.3}).play(0,2).fadeTime_(4);
Ndef(\am1).fadeTime_(4);
Ndef(\am1, {GVerb.ar(SinOsc.ar(["d2".namecps, "d1".namecps])*EnvGen.kr(Env.perc(1, 1)), 78, 99)*0.1}).play(60,2);


// san fernando
t.tempo_(70/60);
a = { Synth(\sampleNarcode, [\buf, ~buffers['bd'], \rel, 1, \out, 8])};

/// backup
~vol = Volume(s, 0, 20);
~vol.gui;
~funcs['fer'] = { m.(a, nil, true, 1, 1, 1, 1).play };

Ndef(\rzo2).stop(3);
(
r = Routine{
	inf.do{
		s.bind{
			// audio
			~funcs.do{|f| f.(); };
		};
		4.wait; // must be dynamic
	}
}.play;
);

r.stop;