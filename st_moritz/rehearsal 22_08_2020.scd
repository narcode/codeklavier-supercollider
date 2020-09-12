///// 22 August 2020

k = Ckalculator.new()
f = CkpianoFX(2,0);

/// asia FX:

f.typicalCK(1, 0.3, 2, 8);

// easter eggs asia:
k.eggbuf_(~buffers['asia'][0]);
k.easter_eggs(2, 6);
k.chunk_(30);


k.lasers(4, 0.1);
k.lrit_(4)

k.laser_saw_freq_("D-1".namecps);
k.laser_rel(10);
k.laser_amp_(0.4);
k.laser_dec_(9);

k.eggbuf_(~buffers['europe'][2]);
c.easter_eggs(2, 6);
c.chunk_(c.num);

(Tdef(\f, {
	loop{
		c.lrit_(1);
		1.wait;
		c.lrit_(1);
		1.wait;
		2.do{c.lrit_(1/2); 0.5.wait;}
	}
}).stop;)

f.typicalCK.stop(18);
f.delayCK(0.2);

c.harmony(2);
c.harm_f1_("D0".namecps)


// europe
k.eggbuf_(~buffers['europe'][2]);
k.easter_eggs(2, 6);
k.chunk_(4);

~funcs = ();

c.harmony();


a = {Synth(\sampleNarcodeStr, [\buf, ~buffers['europe'][0], \rl, 4.rrand(10), \rate, 0.9.rrand(1), \start, 0.1.rrand(0.6), \amp, 0.4, \out, 0])};

b = {Synth(\sampleNarcodeStr, [\buf, ~buffers['europe'][1], \rl, 5, \rate, 1, \start, 0, \amp, 0.3, \out, 2])};

c = {Synth(\sampleNarcodeStr, [\buf, ~buffers['europe'][2], \rl, 3, \rate, 1, \start, 0, \amp, 0.3, \out, 0])};


~funcs['a'] = { PZ_layer(a).rhythm(1,1,1,0) };
~funcs['b'] = { PZ_layer(b).rhythm(0,0,1,0) };
~funcs['c'] = { PZ_layer(b).rhythm(1,1,1,1) };

t.tempo_(0.8)

p = PZ_machine(s);
p.ignite(s, 3);


//// north america

k.eggbuf_(~buffers['namerica'][5]);
k.easter_eggs(2, 10);
k.chunk_(4);

k.harm_f1_(100);
k.harm_f2_(110);
k.harm_f3_(90);

k.harmony_amp_(0.01);
k.harmony

f.noisy(0.9, 145, 4, 0.01, "E3".namecps, 0.1);


k.lasers(4, 4);
k.laser_rel_(3);
k.laser_amp_(0.1)
k.laser_dec_(0.1)
k.laser_noise_freq_(11167)
k.lrit_(16)
k.set_l_(false);
k.lasers.stop;

k.laser_saw_freq_("E1".namecps);

a = {Synth(\sampleNarcodeStr, [\buf, ~buffers['namerica'][6], \rl, 1, \rate, 0.8, \start, 0.1, \amp, 0.2, \out, 0])};

b = {Synth(\sampleNarcodeStr, [\buf, ~buffers['sn'], \rl, 5, \rate, 1, \start, 0, \amp, 1, \out, 2])};

c = {Synth(\sampleNarcodeStr, [\buf, ~buffers['namerica'][3], \rl, 1, \rate, 1, \start, 0, \amp, 1, \out, 0])};

d = {Synth(\sampleNarcodeStr, [\buf, ~buffers['hh'], \rl, 0.1, \rate, 1, \start, 0.01, \amp, 1, \out, 0])};

e = {Synth(\sampleNarcodeStr, [\buf, ~buffers['bd'], \rl, 1, \rate, 1, \start, 0, \amp, 1, \out, 0])};

t.tempo_(105/60);
~funcs = ();
~funcs['a'] = { PZ_layer(a).rhythm([0,1], [0,1], [0,1], [1]) };
~funcs['hh'] = { PZ_layer(d).rhythm([1], [0,1], [1], [0,1,0,1]) };
~funcs['b'] = { PZ_layer(b).rhythm(0,[1],0,2) };
~funcs['c'] = { PZ_layer(c).rhythm(1,1,0,0) };
~funcs['bd'] = { PZ_layer(e).rhythm(1,0,[2],0) };
~funcs['hh'] = ();
p.beats_(4)


~funcs['a'] = { PZ_layer(a).rhythm([0], [0], [0], [0]) };
~funcs['hh'] = { PZ_layer(d).rhythm([0], [0], [0], [0,1,1,2]) };
~funcs['b'] = { PZ_layer(b).rhythm(0,0,[0],0) };
~funcs['c'] = { PZ_layer(c).rhythm(0,0,0,0) };
~funcs['bd'] = { PZ_layer(e).rhythm(0,0,[1],0) };

t.tempo_(105/60);
f.delayCK(1)
f.noisy.stop(10);
k.harmony.stop(10);

// oceania

k.eggbuf_(~buffers['oceania'][1]);
k.easter_eggs(2, 6);



a = {Synth(\sampleNarcodeStr, [\buf, ~buffers['oceania'][1], \rl, 6.rrand(1), \rate, 1, \start, 0.1.rrand(0.9), \amp, 0.2.rrand(0.01), \out, 0])};
b = {Synth(\sampleNarcodeStr, [\buf, ~buffers['oceania'][1], \rl, 1, \rate, 1, \start, 0.1, \amp, 0.2, \out, 0])};
c = {Synth(\sampleNarcodeStr, [\buf, ~buffers['oceania'][2], \rl, 2, \rate, 1, \start, 0.1, \amp, 0.2, \out, 0])};

d = {Synth(\sampleNarcode, [\buf, ~buffers['hh'], \rl, 1, \rate, 1, \start, 0.2, \amp, 1, \out, 0])};
~bd = {Synth(\sampleNarcode, [\buf, ~buffers['bd'], \rl, 1, \rate, 1, \start, 0, \amp, 1, \out, 0])};

t.tempo_(60/60);
~funcs['a'] = { PZ_layer(a).rhythm(1,1,[2],0) };
~funcs['b'] = { PZ_layer(b).rhythm(1,0,1,0) };
~funcs['c'] = { PZ_layer(c).rhythm(0,0,1,0) };
~funcs['sea'] = { PZ_layer(d).rhythm(1,1,0,[0,1]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,0,[0,1]) };
~funcs['bd'] = ();

p = PZ_machine()
p.ignite(s, 4);
p.beats_(4);
~funcs = ();

~d = Synth(\sampleNarcodeStr, [\buf, ~buffers['oceania'][3], \at, 10, \rl, 99, \rate, (1/(3/2)*2), \start, 0.1, \amp, 0.7, \out, 1]);

~sea = Synth(\sampleNarcodeStr, [\buf, ~buffers['oceania'][0], \at, 10, \rl, 99, \rate, 1, \start, 0.1, \amp, 0.01, \out, 0]);

~funcs = ();
Ndef(\d, {PlayBuf.ar(2, ~buffers['oceania'][3], BufRateScale.kr(~buffers['oceania'][3])*(1/(3/2)), 1, 0, loop:1)*EnvGen.kr(Env.adsr(4, 1, 0.35, 10, 0.4))}).play(0,2);

Ndef(\rain, {WhiteNoise.ar(0.1)*LFNoise0.kr(6).range(0, 0.1)*LFPulse.kr(7, width:0.01)}).play(0,2)

Ndef(\rain).stop(2);
Ndef(\del).stop(9);

Ndef(\d).stop(14);
Ndef(\rain, {WhiteNoise.ar(0.1)*LFNoise0.kr(1/2).range(0, 0.1)*LFPulse.kr(1, width:0.01)}).play(0,2)

// oeania fx
f.typicalCK(0.9, 1, 148, 15);

k = Ckalculator("karen", "anne");


// easter eggs africa:
k.eggbuf_(~buffers['bd']);
k.easter_eggs(2, 6);
c.chunk_(1);

k = Ckalculator("xa", "za")

// africa
a = {Synth(\sampleNarcodeStr, [\buf, ~buffers['africa'][1], \rl, 1, \rate, (1/2).rrand(2.0).round(0.5), \start, 0.1, \amp, 0.9, \out, [0,1].choose])};
b = {Synth(\sampleNarcodeStr, [\buf, ~buffers['africa'][1], \rl, 1, \rate, (1/4).rrand(0.75).round(0.25), \amp, 0.9, \start,0.1, \out, [0,1].choose])};
c = {Synth(\sampleNarcodeStr, [\buf, ~buffers['africa'][0], \rl, 1, \rate, 0.8.rrand(1.5), \amp, 0.1.rrand(1), \out, [0,1].choose])};

t.tempo_(142/60);
~funcs['a'] = { PZ_layer(a).rhythm([2],[2],1,1,[2],[2],1,1) };
~funcs['b'] = { PZ_layer(b).rhythm(1,0,[0,0,1],0, 1,0,[0,0,1],0)};
~funcs['c'] = { PZ_layer(c).rhythm([1,0,1],1,[0,0,1],[0])};
~funcs['c1'] = { PZ_layer(c).rhythm(1,0,[0,0,1],0,[0,1,0],0,0)};
~funcs['c2'] = { PZ_layer(c).rhythm(2,0,1,0,0,[2],0)};
~funcs = ();

p.beats_(4);

f.delayCK.stop(5);
f.typicalCK.stop(10);

f.noisy(0.9, 120, 1)
// LC
~funcs['a'] = { PZ_layer(a).rhythm([3],[2],1,1,[2],[2],1,1) };

z = PZ_machine(s);
x.ignite(s, 8);

	// easter eggs
OSCdef(('africa').asSymbol, {|msg, time, addr, recvpPort|
	{
	~funcs['c'] = { PZ_layer(~bd).rhythm([1],0,1,[0])};
		(24).wait;
		~funcs['c'] = ();
	}.fork
	}, '/ck_easteregg').free;



///// southamerica
~funcs = ();
k.free;
k = Ckalculator("juan", "juan", "juan");

t.tempo_(50/60);
a = {Synth(\sampleNarcodeStr, [\buf, ~buffers['samerica'][1], \rl, 10, \rate, 1, \amp, 0.01.rrand(0.2), \out, [0,1].choose])};

p.beats

~funcs['a'] = { PZ_layer(a).rhythm(1,1,0,0); }
~funcs = ();
p.ignite(s, 4)
f.noisy.stop(1)
f.delayCK(0.95, 0.2, 9);

"say -v ju ".unixCmd;

k.voices = false;
k.voicevol_(0);

k.eggbuf_(~buffers['samerica'][0]);

///// antarctica
~funcs = ();

k.eggbuf_(~buffers['antarctica'][1]);

k = Ckalculator.new();
k.voicevol_(0.1) /// chek voices
k.voices_(false);
f = CkpianoFX(2,0);
k.free;
f.delayCK(0.1, Ndef(\k, {LFNoise1.kr(1/20).range(0.01, 1).round(0.125)}), 100, 1/3);


f.delayCK(0.3, Ndef(\k, {LFNoise1.kr(1/10).range(0.01, 1).round(0.125)}), 100, 1/3);


a = {Synth(\sampleNarcodeStr, [\buf, ~buffers['antarctica'][[0,1,2,4].choose], \rl, 10, \rate, 1, \amp,0.1])};
b = {Synth(\sampleNarcodeStr, [\buf, ~buffers['antarctica'][[0,1,2,3,4].choose], \rl, 10, \rate, 1, \amp,0.1])};

p = PZ_machine(s)
p.beats_(8);
~funcs['a'] = {PZ_layer(a).rhythm(1,0,0,0,0,0)};
~funcs['b'] = {PZ_layer(a).rhythm(1,0,1,[2],0,0)};

~funcs=();
f.delayCK(0.3, 20, 99);

k.free




////// world
k = Ckalculator.new("tri", "tri");

f.delayCK(1.4, Ndef(\k, {LFTri.kr(1/2).range(0.01, 1).round(0.125)}), 100, 1);

f.delayCK.stop(4);