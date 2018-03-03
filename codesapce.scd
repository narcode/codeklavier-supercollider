 // universal
~path = thisProcess.nowExecutingPath.dirname
(~path ++ "/CK_environment.scd").load;

// hello world (various versions)
(~path ++ "/CodeKlavier_hello_world_nkk.scd").load; // installation version
(~path ++ "/CodeKlavier_hello_world_v_RTP.scd").load; // when controlling external instrument (RTP)
(~path ++ "/CodeKlavier_hello_world_v_sampler.scd").load; // normal sampler (RTP replica)
(~path ++ "/CodeKlavier_hello_world_v_fx.scd").load; // with FX (SHA)
(~path ++ "/CodeKlavier_hello_world_v_no_ccPedal.scd").load; // if missing CC messages in Sustain Pedal
(~path ++ "/CodeKlavier_hello_world_v_Huygens.scd").load; // special samples based on Air De Cour
(~path ++ "/CodeKlavier_hello_world_v_Huygens_noCCpedal.scd").load;
{2.do{(~path ++ "/toypiano_sampler.scd").load; 2.wait}}.fork;

// mottipets:
(~path ++ "/snippets.scd").load;


//////////// ⬇




~dn



~down2=1
~ost.stop

~hello.stop
~hello2.stop
~hello3.stop
