 // universal
~path = thisProcess.nowExecutingPath.dirname
s.meter.window.alwaysOnTop_(true)
(~path ++ "/CodeKlavier_hybrid_huygens_NOCC_Pedal.scd").load; // special samples based on Air De Cour
// load the sampler:
{2.do{(~path ++ "/toypiano_sampler.scd").load; 2.wait}}.fork;

// mottipets:
(~path ++ "/snippets.scd").load;
(~path ++ "/CK_environment.scd").load;

//// codespace \\\\

Ndef(\tp, {CombN.ar(PitchShift.ar(FreqShift.ar(SoundIn.ar(0,1), LFTri.kr(1/42).range(1, 234)), 0.1, [8, 12/5]), 1, LFNoise0.kr(1/8).range(0.1, 1), 7)*FSinOsc.kr(4).range(0.8, 1)*1}).play(0,2);
