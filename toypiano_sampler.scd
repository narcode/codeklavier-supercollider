/*

-> toy piano sampler by narcode. April v2.0 <-

Thanks to Anne Veinberg for Recording this

*/

{
// load the custom toy piano samples
~buffer = ();
~headG = Group.new(s, \addToHead);
~pathsamples = thisProcess.nowExecutingPath.dirname;
s.sync;

// load all the samples:
// (organ + toy piano + clock)
44.do{|i|
  ~num = 24 + i;
  ~buffer[i] = Buffer.read(s, ~pathsamples++"/TPSamples/"++~num++".wav");
};
s.sync;

~srcid = -1869464304; // annerob: 1151127154 felipe 1429867122 anne -1869464304
~amp_tp = 0.52;
~amp_org = 1;
~clockamp = 0.5;
~amp_tpfx = 0.52;
~midiBufferOffset = 44;

//player synth:
SynthDef(\ck_sampler, {|amp=0.52, buffer, out=0, at=0.02, rl=1.5|
		var sampler = PlayBuf.ar(2, buffer) * amp;
		var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
		Out.ar(out, sampler*env);
}).store;


// sampler node:
MIDIdef.noteOn(\toypiano, {arg ...args;
  var midinote = args[1]-~midiBufferOffset; // 57 - 44 = 13
  // args.postln;
  // midinote.postln;
if (midinote < 64 && midinote >= 0) {
			Synth(\ck_sampler, [\amp, ~clockamp, \buffer, midinote, \out, 0], ~headG);
			Synth(\ck_sampler, [\amp, ~clockamp, \buffer, midinote, \out, 6], ~headG);
    }
  }, chan: 0, srcID: ~srcid);

// channel 1:
  MIDIdef.noteOn(\toypiano1, {arg ...args;
    var midinote = args[1]-~midiBufferOffset;
    /*args.postln;*/
    // midinote.postln;
  if (midinote < 64 && midinote >= 0) {
			Synth(\ck_sampler, [\amp, ~amp_tp, \buffer, midinote, \out, 0], ~headG);
			Synth(\ck_sampler, [\amp, ~amp_tpfx, \buffer, midinote, \out, 8], ~headG);
      }
    }, chan: 1, srcID: ~srcid); // 1151127154


    // channel 2:
      MIDIdef.noteOn(\toypiano2, {arg ...args;
        var midinote = args[1]-~midiBufferOffset;
        var duplicate = midinote.asString++"d";
        /*args.postln;*/
        //midinote.postln;

      if (midinote < 64 && midinote >= 0) {
			Synth(\ck_sampler, [\amp, ~amp_tp, \buffer, midinote, \out, 0], ~headG);
			Synth(\ck_sampler, [\amp, ~samplerafx, \buffer, midinote, \out, 6], ~headG);
          }
        }, chan: 2, srcID: ~srcid); // 1151127154

        // channel 3:
          MIDIdef.noteOn(\toypiano3, {arg ...args;
            var midinote = args[1]-~midiBufferOffset;
            // args.postln;
            // (midinote+24).postln;

          if (midinote >= 0) {
			  Synth(\ck_sampler, [\amp, ~amp_tp, \buffer, midinote, \out, 0], ~headG);
              }
            }, chan: 3, srcID: ~srcid); // 1151127154

            // channle 4 (ostinatos):
            MIDIdef.noteOn(\toypiano_ost, {arg ...args;
              var midinote = args[1]-~midiBufferOffset;
              // args.postln;
              //midinote.postln;
            if (midinote < 64 && midinote >= 0) {
            			Synth(\ck_sampler, [\amp, ~amp_tp, \buffer, midinote, \out, 0], ~headG);
                }
              }, chan: 4, srcID: ~srcid);

        // channel 5 (organ):
        MIDIdef.noteOn(\5, {arg ...args;
          var midinote = args[1]-~midiBufferOffset;
          // args.postln;
          // (midinote+24).postln;

        if (midinote >= 0) {
            Synth(\ck_sampler, [\amp, ~amp_org, \buffer, midinote, \out, 0, \rl, ~od1*2], ~headG);
            }
          }, chan: 5, srcID: ~srcid);

          // channel 6 (organ):
          MIDIdef.noteOn(\6, {arg ...args;
            var midinote = args[1]-~midiBufferOffset;

          if (midinote >= 0) {
              Synth(\ck_sampler, [\amp, ~amp_org, \buffer, midinote, \out, 0, \rl, ~od1*2], ~headG);
              Synth(\ck_sampler, [\amp, ~amp_org, \buffer, midinote, \out, 6, \rl, ~od1*2], ~headG);
              }
            }, chan: 6, srcID: ~srcid);

            // channel 7 (organ):
            MIDIdef.noteOn(\7, {arg ...args;
              var midinote = args[1]-~midiBufferOffset;

            if (midinote >= 0) {
                Synth(\ck_sampler, [\amp, ~amp_org, \buffer, midinote, \out, 0, \rl, ~od1*2], ~headG);
                Synth(\ck_sampler, [\amp, ~amp_org, \buffer, midinote, \out, 8, \rl, ~od1*2], ~headG);
                }
              }, chan: 7, srcID: ~srcid);

s.sync;
"Toy piano sampler ready!".postln;
s.sync;
// fx:
~gtail = Group.new(s, \addToTail);
Ndef(\fx, {|del=1, amp=0.001| CombN.ar(In.ar(6), 0.2, del.reciprocal, 4)*amp}).play(0, group: ~gtail);
s.sync;
Ndef(\fx1, {|del=1, amp=0.001| CombN.ar(In.ar(8), 0.2, del.reciprocal, 1)*amp}).play(1, group: ~gtail);
s.sync;
Ndef(\fx2, {|del=2, amp=0.001, rate=1| GVerb.ar(FreqShift.ar(In.ar(6), LFTri.kr(rate.reciprocal).range(8000, 100)), 62, del)*amp}).play(0,2, group: ~gtail);
s.sync;
"fx ready!".postln;
}.fork;
