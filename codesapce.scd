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
