 // universal
~path = thisProcess.nowExecutingPath.dirname
(~path ++ "/CK_environment.scd").load;

// hello world Nacht van Kunst en Kennis
(~path ++ "/CodeKlavier_hello_world_nkk.scd").load;
{2.do{(~path ++ "/toypiano_sampler.scd").load; 2.wait}}.fork;

// mottipets:
(~path ++ "/snippets.scd").load;


//////////// ⬇
