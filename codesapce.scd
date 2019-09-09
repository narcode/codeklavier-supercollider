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
~snippet1 = Ndef(\piano_fx, {|dec=40, amp=0.01, rate=1| GVerb.ar(HPF.ar(SoundIn.ar(2,2), 9), 109, dec)*LFTri.kr(rate)*amp}).play(0,2)
~map_amplitude = true;  Ndef(\piano_fx).map(\amp, Ndef(\krm1_a)); ~tremoloL1amp;
~tremoloL1amp = 3
~tremoloL1amp = 5
