 // universal
~path = thisProcess.nowExecutingPath.dirname;
s.meter.window.alwaysOnTop_(true);
(~path ++ "/CodeKlavier_hybrid_Gaudeamus.scd").load; // special samples based on Air De Cour

// load the sampler:
{2.do{(~path ++ "/toypiano_sampler.scd").load; 2.wait}}.fork;

// mottipets:
(~path ++ "/snippets.scd").load;
(~path ++ "/CK_environment.scd").load;

//// codespace \\\\
