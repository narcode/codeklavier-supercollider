// asia (fx)

c = Ckalculator.new();
f = CkpianoFX(2,0);

// CORRECTIONS:
// put special_num in ini
// PZ beats should be able to renew routine

r = {
	loop{
			c.num.postln;
c.laser_saw_freq_(c.num);
1.wait;
	}
}.fork;

r.stop

// ASIA FX:
f.typicalCK(0.55, 0.3, 2, 18); // cool for bass

f.typicalCK.stop(5);

f.delayCK(0.3, dec:10, tempo:1);

k.laser_amp_(0.02);
k.laser_dec_(6);
// noise_amp
k.laser_rel_(0.1);
k.laser_noise_freq_(k.num);
k.laser_saw_freq_(["C2".namecps]);
k.lrit_(8);
k.set_l = false;
k.lasers;


// easter eggs asia:
c.eggbuf_(~buffers['asia'][0]);
c.easter_eggs(2, 6);
c.chunk_(1);

//
c.eggbuf_(~buffers['europe'][2]);
c.easter_eggs(2, 6);
c.chunk_(c.num);

f.delayCK(0.4);

// europe
f.noisy(1, 8, 68, 0.1, "D3".namecps, 0.1);

f.typicalCK(0.2, [2, 1.5, 5/4], 4, 14).stop(4);
f.delayCK.stop(3);

a = {Synth(\sampleNarcodeStr, [\buf, ~buffers['europe'][0], \rl, 0.2.rrand(0.7), \rate, 1.rrand(4), \start, 0.2.rrand(0.9), \amp, 5, \out, 2])};

b = {Synth(\sampleNarcodeStr, [\buf, ~buffers['europe'][2], \rl, 4, \rate, 2.rrand(0.5), \start, 0.5, \amp, 1, \out, 2])};

~funcs = ();
~funcs['a'] = { PZ_layer(a).rhythm([1,2], [1,2], [4], [1,0,1], [1,0,1], [1,0,1]) };
~funcs['b'] = { PZ_layer(b).rhythm([0,1], [1], [1], 1, 1,[0],0) };

t.tempo_(1.4);

p = PZ_machine.new(s);
p.ignite(s, 4);
p.beats_(6);


(Tdef(\r, {
	loop{
		c.lrit_(1/6);
		2.wait;
		c.lrit_(1/2);
		6.wait;
	}
}).play);

c.harmony();
