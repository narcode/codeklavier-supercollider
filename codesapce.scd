 // universal
~path = thisProcess.nowExecutingPath.dirname;
s.meter.window.alwaysOnTop_(true);
//(~path ++ "/CodeKlavier_hybrid_huygens_NOCC_Pedal.scd").load; // special samples based on Air De Cour
(~path ++ "/CodeKlavier_hybrid_gaudeamus.scd").load;
// load the sampler:
{2.do{(~path ++ "/toypiano_sampler.scd").load; 2.wait}}.fork;

// mottipets:
(~path ++ "/snippets.scd").load;
(~path ++ "/CK_environment.scd").load;

//codespace

co
codeklavier meets disklavier

~piano.play
~pno1=11+1+12
~piano2.play
~pno2=23+10
~pnod2=2/2/2
~piano3.play
~pno3=1-13-3-1-1-1-1
~pnod3=1
~pnod2=1/2/3
~piano
~pno2=33+1+1+1-1+1-1+1
~ost.play

// setting up an ONGOING conditional: IF range is less than...
// if true -> play disklavier gong
flash:range set to:  76 semitones...
// setting up an ONGOING conditional: IF range is more than...
// if true -> play disklavier gong
flash:range set to:  4 semitones...

~pno2=33-1-1oo
tt~pnod
pnod3=1/2
~pnod2=1/3
~pnoamp=0.3

~map_amp_ost = true; ~tremoloM1;
~tremoloM1 = 6
~tremoloM1 = 7
~tremoloM1 = 8
~tremoloM1 = 9
~tremoloM1 = 9
Ndef(\acc).map(\note, Ndef(\krm2_1)); ~tremoloM2;

a=2
b=2c
c=2~op
~op1=1
a=2*2
gggggg
~snippet1 = Ndef(\piano_fx, {|dec=40, amp=0.01, rate=1| GVerb.ar(HPF.ar(SoundIn.ar(2,0), 9), 109, dec)*LFTri.kr(rate)*amp}).play(0,2)
~map_amplitude = true;  Ndef(\piano_fx).map(\amp, Ndef(\krm1_a)); ~tremoloL1amp;
~tremoloL1amp = 3
~tremoloL1amp = 5
~tremoloL1amp = 5
~tremoloL1amp = 7
~tremoloL1amp = 7
~tremoloL1amp = 7
Ndef(\piano_fx).map(\dec, Ndef(\krm1_d)); ~tremoloH1
~tremoloH1 = 12
