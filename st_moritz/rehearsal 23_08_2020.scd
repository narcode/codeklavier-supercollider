///// 23

//// CORRECTIONS:

/// contorl volume on easter eggs
/// voices of countries for numbers



k = Ckalculator();
f = CkpianoFX(2,2);

k.num


(OSCdef(\trig, {|msg|
f.delayCK(0.1, Ndef(\k, {LFNoise1.kr(1/20).range(0.01, 1).round(0.125)}), 100, 1/3);
}, '/ck'));

f.typicalCK(1, 0.3, 2,10);

k.eggbuf_(~buffers['asia'][0]);
k.easter_eggs(2, 6);
k.chunk_(30);

(Tdef(\f, {
	loop{
		k.lrit_(1);
		1.wait;
		k.lrit_(1);
		1.wait;
		2.do{k.lrit_(1/2); 0.5.wait;}
	}
}).stop;)


k.laser_dec_(20)
k.laser_amp_(0.001)
k.laser_rel_(1)


k.laser_amp_(0.01);
k.laser_dec_(6);
// noise_amp
k.laser_rel_(0.1);
k.laser_noise_freq_(k.num);
k.laser_saw_freq_(["D2".namecps]);
k.lrit_(8);
k.set_l = false;

f.delayCK(0.8, 0.2, 5);


//// asia

Ndef(\d, {PlayBuf.ar(2, ~buffers['asia'][0], BufRateScale.kr(~buffers['asia'][0])*1/4, 1, 0, loop:0)*EnvGen.kr(Env.adsr(4, 1, 0.35, 10, 0.4))}).play(0,2);


// europe:


f.delayCK(0.1, Ndef(\k, {LFNoise1.kr(1/20).range(0.01, 1).round(0.125)}), 100, 1/3);
