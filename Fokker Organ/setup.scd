//// FOCKKER ORGAN SETUP
s.waitForBoot{
{
MIDIClient.init;
s.sync;
m = MIDIOut.newByName("USB MIDI Interface", "USB MIDI Interface");
//f = MIDIOut.newByName("MIDIMATE II", "Port 1");   /// test midi outs
MIDIIn.connectAll;
s.sync;
// The IAC Bus will now also appear to other applications.
s.sync;

//MIDIdef.noteOn(\test1, {arg ...args; args.postln});
/*
//start
// mini test
m.noteOn(0, 39, 127);
m.noteOff(0, 39, 64);

// lang zal ze leven
m.noteOn(0, 24, 64);
m.noteOn(0, 25, 64);

m.allNotesOff(0);

// program change

// MIDI program change messages on Channel 0 >>>> MAKE GUI TO MAKE IMPRO EASIER

//REGSITER       ON  | OFF
//Subbas16’       0  | 1
m.program(0, 0);
//Gedekt8’        2  | 3
m.program(0, 2);
//P+I             4  | 5
m.program(0, 4);
//P+II            6  | 7
m.program(0, 6);
//Quintadena 8’   8  | 9
m.program(0, 8);
//Prestant 4’     10 | 11
m.program(0, 10);
//I+II            12 | 13
m.program(0, 12);
//Salicionaal 8’  14 | 15
m.program(0, 14);
//Roerfluit 4’    16 | 17
m.program(0, 16);


// RANGES \\
// -> Pedal
36-53
"c1".namemidi;
"f2".namemidi;

// -> Man I * II
36-91
"c1".namemidi;
"g5".namemidi;


// channels:
0-2: manual I
3-5: pedal
6-9: manual II*/

2.wait;
// MIDI mapping to registers...
MIDIdef.cc(\register, {arg ...args;
	if (args[1] == 41) {//Subbas16’
		if (args[0] > 50 ) { m.program(0, 0); } { m.program(0, 1); };
	};

	if (args[1] == 42) {//Gedekt8’
		if (args[0] > 50 ) { m.program(0, 2); } { m.program(0, 3); };
	};

	if (args[1] == 43) {//P+I
		if (args[0] > 50 ) { m.program(0, 4); } { m.program(0, 5); };
	};

	if (args[1] == 44) {//P+II
		if (args[0] > 50 ) { m.program(0, 6); } { m.program(0, 7); };
	};

	if (args[1] == 45) {//Quintadena 8’
		if (args[0] > 50 ) { m.program(0, 8); } { m.program(0, 9); };
	};

	if (args[1] == 46) {//Prestant 4’
		if (args[0] > 50 ) { m.program(0, 10); } { m.program(0, 11); };
	};

	if (args[1] == 47) {//I+II
		if (args[0] > 50 ) { m.program(0, 12); } { m.program(0, 13); };
	};

	if (args[1] == 48) {//Salicionaal 8’
		if (args[0] > 50 ) { m.program(0, 14); } { m.program(0, 15); };
	};

	if (args[1] == 49) {//Roerfluit 4’
		if (args[0] > 50 ) { m.program(0, 16); } { m.program(0, 17); };
	};

});

s.sync;
		}.fork;
};