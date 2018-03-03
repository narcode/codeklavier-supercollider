 // universal
~path = thisProcess.nowExecutingPath.dirname
(~path ++ "/CK_environment.scd").load;

// hello world (various versions)
(~path ++ "/CodeKlavier_hello_world_nkk.scd").load;
(~path ++ "/CodeKlavier_hello_world_v_RTP.scd").load;
(~path ++ "/CodeKlavier_hello_world_v_sampler.scd").load;
{2.do{(~path ++ "/toypiano_sampler.scd").load; 2.wait}}.fork;

// mottipets:
(~path ++ "/snippets.scd").load;


//////////// ⬇


~ost=Pdef(\ostinato1, {Pbind(\dur, Pseq([Pfuncn({1/h}, 1), Pfuncn({1/e},1), Pfuncn({1/l},1)], inf), \ctranspose, Pfunc{~pitch},
\midinote, Pseq(["d3".namemidi, "B2".namemidi, "g3".namemidi, "g3".namemidi,
"a3".namemidi, "g3".namemidi, "b3".namemidi, "c#4".namemidi, "d4".namemidi, "a3".namemidi,
"b3".namemidi, "a3".namemidi, "g3".namemidi, "f#3".namemidi, "e3".namemidi, "d3".namemidi], inf),
\type, \midi, \midiout, m)});

~ost.play;
~hello.play
