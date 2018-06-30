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
















hello
hellowordl wordl rowdl wlord wdolrwdrolwodlrowrld wordl world
hello musa
~hello.play
~p1o=1+1+1+1+1
t.tempo=2
~hello2.play
~p2o=23
~hello3.play
~p3o=3+3+3

~snippet1 = Ndef(\piano_fx, {|dec=40, amp=0.01, rate=1| GVerb.ar(HPF.ar(SoundIn.ar(0,2), 9), 109, dec)*LFTri.kr(rate)*amp}).play(0,2)
~map_amplitude = true;  Ndef(\piano_fx).map(\amp, Ndef(\krm1_a)); ~tremoloL1amp;
~tremoloL1amp = 9
~map_sampler = true; ~tremoloM1;
~tremoloM1 = 7
~tremoloM1 = 4
Ndef(\piano_fx).map(\dec, Ndef(\krm1_d)); ~tremoloH1;
~tremoloH1 = 12
~tremoloL1amp = 2
// setting up an ONGOING conditional: IF range is more than...
// if true -> play gong sound!
range set to:  12 semitones...

30
~clock.play

~tremoloL1amp = 5
~tremoloM1 = 7
// setting up an ONGOING conditional: IF range is more than...
// if true -> play gong sound!
~tremoloM1 = 2
range set to:  2 semitones...
~tremoloM1 = 11
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloM1 = 11
~tremoloM1 = 11
~tremoloM1 = 11
~tremoloM1 = 11
// setting up an ONGOING conditional: IF range is more than...
// if true -> play Huyg
range set to:  11 semitones...

~eamp=1

~tremoloM1 = 10
~tremoloM1 = 2
~tremoloM1 = 8
~tremoloM1 = 10
~tremoloM1 = 2
~tremoloM1 = 10
~tremoloM1 = 2
~tremoloM1 = 4
~tremoloL1amp = 5
~snippet2 = Ndef(\acc, {|note=500, amp=0.036, cut=200, bw=0.5, fx=0.1| BPF.ar(Resonz.ar(SinOsc.ar([note.lag(1), note.lag(2)*3/2, note*2, note.lag(1.5)*4/3]), (note*LFTri.kr(fx).range(1/2, 8))+80, bw), 600, 0.8) * amp.lag(0.5)}).play(0,2);
~tremoloM1 = 10
~tremoloM1 = 2
~tremoloM1 = 10
~tremoloM1 = 11

11111111o11
111111os11
111o1s1t111
111o1s1t11in111
11111o1s1t11in1a11
111o1s11t1in1a1t111o11
1111
1112
3edl

o
ost
ostin
ostina
ostinato
~ost.play
h=e=l=2+2+10

~tremoloM1 = 4
~tremoloM1 = 11
~tremoloM1 = 4
~tremoloM1 = 11
~tremoloM1 = 4
~tremoloM1 = 11
~tremoloM1 = 4
// setting up an ONGOING conditional: IF range is more than...
~tremoloM1 = 11
~tremoloM1 = 4
~tremoloM1 = 11
// if true -> play Huyg
~tremoloM1 = 4
range set to:  4 semitones...
~tremoloM1 = 11
~tremoloM1 = 4
~tremoloM1 = 11
~tremoloM1 = 4
~tremoloM1 = 11
~tremoloM1 = 4
~tremoloM1 = 11
~tremoloM1 = 4
~tremoloM1 = 2
~tremoloM1 = 4
~tremoloM1 = 4
~tremoloM1 = 3
~tremoloM1 = 4
~tremoloM1 = 3
~tremoloM1 = 4
~tremoloM1 = 5
~tremoloM1 = 6

~op=1

~tremoloM1 = 12
~tremoloM1 = 10
~tremoloM1 = 12
Ndef(\acc).map(\amp, Ndef(\krm2_2)); ~tremoloL2
~tremoloL2 = 4
~tremoloM1 = 11
~tremoloL2 = 3
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloL2 = 5
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloL2 = 7
~tremoloM1 = 2
~tremoloL2 = 8
~tremoloM1 = 11
~tremoloL2 = 9
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloL2 = 9
~tremoloM1 = 2
~tremoloL2 = 3
// setting up a conditional: IF number of            notes played is more than 100 in...
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloM1 = 2
~tremoloM1 = 11
~tremoloM1 = 2
// if true -> play gong sound!
~tremoloM1 = 11
more than 100 notes played in the next  11 seconds?
notes played:  0
~tremoloM1 = 2
notes played:  8
~tremoloM1 = 11
notes played:  18
notes played:  27
notes played:  40
notes played:  54
notes played:  67
~tremoloM1 = 9
notes played:  77
notes played:  85
Ndef(\acc).map(\amp, Ndef(\krm2_2)); ~tremoloL2
notes played:  97
Total notes played:  105!!!
~tremoloM1 = 2
~tremoloM1 = 9
~tremoloM1 = 11
~tremoloM1 = 9
~tremoloM1 = 11
~tremoloM1 = 2
~tremoloM1 = 9
~tremoloM1 = 2
~tremoloH1 = 20
Ndef(\acc).map(\fx, Ndef(\krm2_3)); ~tremoloH2;
Ndef(\acc).map(\fx, Ndef(\krm2_3)); ~tremoloH2;
~tremoloH2 = 1
~tremoloH2 = 2
~tremoloH2 = 4
~tremoloH2 = 5
~tremoloH2 = 6
~tremoloH2 = 7
~tremoloH2 = 12
~tremoloM1 = 2
~tremoloM1 = 2
~tremoloH2 = 12
~tremoloM1 = 2
~tremoloH2 = 12
~tremoloH2 = 12
~tremoloM1 = 6
~tremoloM1 = 6
~tremoloM1 = 5
~tremoloM1 = 4
~tremoloM1 = 4
~tremoloM1 = 3
~tremoloH2 = 12
~tremoloH2 = 12
~tremoloH2 = 12
~tremoloH2 = 12
~tremoloM1 = 1

~eamp=2
~del=23
~clock2.play
~clock3.play
llllc
~tremoloH2 = 14
~tremoloH2 = 13
~tremoloH2 = 12
Ndef(\acc).map(\amp, Ndef(\krm2_2)); ~tremoloL2
~tremoloL2 = 7
~tremoloL2 = 8
~tremoloL2 = 9
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloH2 = 12
~tremoloM1 = 1
~tremoloH2 = 12
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloM1 = 1
~tremoloL2 = 8
// setting up a conditional: IF number of            notes played is more than 100 in...
~tremoloH2 = 14
~tremoloH2 = 14
~tremoloH2 = 11
~tremoloH2 = 14
~tremoloH2 = 2
~tremoloH2 = 14
~tremoloH2 = 14
~tremoloH2 = 12
~tremoloH2 = 14
~tremoloH2 = 7
~tremoloH2 = 14
~tremoloH2 = 7
~tremoloH2 = 2
~tremoloL2 = 10
~tremoloH2 = 2
Ndef(\acc).map(\note, Ndef(\krm2_1)); ~tremoloM2;
~tremoloM2 = 4
~tremoloM2 = 5
~tremoloM2 = 1
~tremoloM2 = 12
~tremoloM2 = 9
~tremoloM2 = 1
~tremoloM2 = 4
~tremoloM2 = 5
~tremoloM2 = 2
~tremoloM2 = 3
~tremoloM2 = 6

~eamp=0.3

~tremoloL2 = 1
HUYGENS! //is activating...
~tremoloM2 = 24
GOMB countdown set to:  24
notes played:  0
notes played:  1
notes played:  5
notes played:  5
notes played:  7
notes played:  11
notes played:  14
~tremoloH2 = 4
notes played:  21
notes played:  24
notes played:  33
notes played:  40
notes played:  44
notes played:  47
notes played:  50
notes played:  52
notes played:  54
notes played:  60
notes played:  68
notes played:  76
notes played:  88
Total notes played:  101!!!
// HUYGENS countdown started!

~s3o
~p3o=23
~stop.now;~huygens.end;
~snippet2.stop(0.5);
~snippet1.stop(10);

  ____   ____   ____  __  __ _
 |  _ \ / __ \ / __ \|  \/  | |
 | |_) | |  | | |  | | \  / | |
 |  _ <| |  | | |  | | |\/| | |
 | |_) | |__| | |__| | |  | |_|
 |____/ \____/ \____/|_|  |_(_)   (^0^)//¯  AIR DE COUR  THE END ¯\('…')/¯
