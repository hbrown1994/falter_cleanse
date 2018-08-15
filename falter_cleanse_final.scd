
(
/*
Falter Cleanse
Viola & Electronics
Hunter Brown
©2018

Last Updated: 05/17/18
1. Go to the Supercollider Menu and select Language->Evaluate File.
2. Wait for Script to Run
3. Once the program is finished booting -> Indicated by a "done" message in SuperCollider's Post Window -> Press the button labeled "Initialization." The string microphones and the "Dry String Sound" modules are activated. You can now test the dry string sounds.
4. Once you are ready to start the piece, press the "Cue" button to actuate the first rehearsal cue.
5. To Stop and Restart from any rehearsal cue -> Press "Stop & Reset" -> Press "Initialization" -> Select the rehearsal cue from which you wish to begin from the "Rehearsal Cues" Module -> Press "Cue" to actuate this rehearsal cue. -> Repeat as needed for rehearsal.
6. If for any reason the comptuer part crashes or glitches -> Go to the Supercollider Menu and select Server -> Kill All Servers -> Then Repeat Steps 1 through 4.

For more information, feel free to contact Hunter at hunterbrownmusic1@gmail.com
*/

//DO NOT ALTER ANY CODE BELOW THIS LINE////////////////////////////////////////////
//1. server config
s = Server.local;
s.newBusAllocators;
s.latency = 0.05;
ServerBoot.removeAll;
ServerTree.removeAll;
ServerQuit.removeAll;
Server.local.options.numOutputBusChannels = 5;    // change number of input and output channels
Server.local.options.numInputBusChannels = 3;
o=s.options;
o.memSize = 2.pow(20);






//2. initialize global variables

~viola_in = 0;
~micchannel_1 = 0;
~micchannel_2 = 2;
~channelAmount = 3;
~cue=0;
~sub_out=0;
~path = PathName(thisProcess.nowExecutingPath).parentPath++"buffers/";


//3. Make Buffers
~makeBuffers = {
~fftBuff = Buffer.alloc(s, 2048, 1);

b = Dictionary.new;
PathName(~path).entries.do{
	arg subfolder;
	b.add(
		subfolder.folderName.asSymbol ->
		Array.fill(
			subfolder.entries.size,
			{
				arg i;
					Buffer.read(s, subfolder.entries[i].fullPath);
				}
			)
		);
	};

m = Dictionary.new;
PathName(~path).entries.do{
	arg subfolder;
	m.add(
		subfolder.folderName.asSymbol ->
		Array.fill(
			subfolder.entries.size,
			{
				arg i;
					Buffer.readChannel(s, subfolder.entries[i].fullPath, channels: 0);
				}
			)
		);
	};

};


//4. Make Nodes
~makeNodes = {
	~patterns = Group.new;
	~input = Group.after(~patterns);
	~ampTrack = Group.after(~input);
	~fx = Group.after(~ampTrack);
	~sine = Group.after(~fx);
};

//4. Make MIDI
~makeMIDI = {

	MIDIdef.cc(\knob_1, {
		arg val;
		~knob_1 = val.linlin(0, 127, -60.0, 0.0);

		{c[2].children[4].valueAction_(~knob_1)}.defer;

	}, 16);

	MIDIdef.cc(\knob_2, {
		arg val;
		~knob_2 = val.linlin(0, 127, -60.0, 5.0);

		{c[2].children[5].valueAction_(~knob_2)}.defer;
	}, 17);

	MIDIdef.cc(\knob_3, {
		arg val;
		~knob_3 = val.linlin(0, 127, -60.0, 0.0);

		{c[2].children[6].valueAction_(~knob_3)}.defer;
	}, 18);

	MIDIdef.cc(\knob_0, {
		arg val;
		~knob_0 = val.linlin(0, 127, 30.0, 100.0);

		{c[2].children[7].valueAction_(~knob_0)}.defer;
	}, 19);



	MIDIdef.cc(\knob_4, {
		arg val;
		~knob_4 = val.linlin(0, 127, -60.0, 0.0);

		{c[4].children[5].valueAction_(~knob_4)}.defer;
	}, 0);

	MIDIdef.cc(\knob_5, {
		arg val;
		~knob_5 = val.linlin(0, 127, -60.0, 0.0);

		{c[4].children[6].valueAction_(~knob_5)}.defer;
	}, 1);

	MIDIdef.cc(\knob_6, {
		arg val;
		~knob_6 = val.linlin(0, 127, -60.0, 5.0);

		{c[4].children[7].valueAction_(~knob_6)}.defer;
	}, 2);

	MIDIdef.cc(\knob_7, {
		arg val;
		~knob_7 = val.linlin(0, 127, -60.0, 0.0);

		{c[4].children[8].valueAction_(~knob_7)}.defer;
	}, 3);

	MIDIdef.cc(\knob_8, {
		arg val;
		~knob_8 = val.linlin(0, 127, -60.0, 0.0);

		{c[4].children[9].valueAction_(~knob_8)}.defer;
	}, 4);

	MIDIdef.cc(\knob_16, {
		arg val;
		~knob_16 = val.linlin(0, 127, -60.0, 0.0);

		{c[5].children[3].valueAction_(~knob_16)}.defer;

	}, 5);

	MIDIdef.cc(\knob_17, {
		arg val;
		~knob_17 = val.linlin(0, 127, -60.0, 0.0);

		{c[5].children[4].valueAction_(~knob_17)}.defer;
	}, 6);

	MIDIdef.cc(\knob_18, {
		arg val;
		~knob_18 = val.linlin(0, 127, -60.0, 0.0);

		{c[5].children[5].valueAction_(~knob_18)}.defer;
	}, 7);


};

//5. Make Events/MIDI
~makeEvents = {

	MIDIClient.init(4, 4, verbose: true);

	MIDIIn.connectAll;

	e = Dictionary.new;

	//SynthDef init
		e.add(\init -> {

	 Routine({
	//~viola = Synth(\input_1, [\outputbusFX, ~fxBus, \outputbusCV, ~cvBus, \atk, 0.005, \rel, 0.05], target: ~input).register;

			~viola = Synth(\input_1, [\outputbusFX, ~fxBus, \outputbusCV, ~cvBus, \atk, 0.1, \rel, 0.1], target: ~input).register;

	s.sync;

    Synth(\amptracking, [\inputbus, ~cvBus, \outputbus, ~cvBusSend], target: ~ampTrack);



}).play(AppClock);

});


	e.add(\stop_reset -> {
	        ~cue=0;

		    c[0].children[0].value_(0);

		    Routine({
		    ~metalPicks.stop;
		    ~cringle.stop;
		    ~overP.stop;
		    ~overPressure.stop;

			s.sync;

		     s.freeAll;
		}).play(AppClock);

		    36.do{
			arg i=(-1);
		   {i = i + 1};
		c[1].children[i].value_(0)
		}
	});

	e.add(\0 -> {

	"cue 0".postln;
	c[1].children[0].value_(1);//On

	Routine({
~glitch = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 1, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 20, \brickMult, 0.2, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;

	75.wait;

	~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][12], \loop, 1, \gate, 1, \atk, 140, \rel, 0.05, \curve,0, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][15], \loop, 1, \gate, 1,
				\atk, 140, \rel, 0.05, \curve, 0, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	}).play(AppClock);



	});

	e.add(\1 -> {
	c[1].children[0].value_(0);//Off
	c[1].children[1].value_(1);//On


	~glitch.set(\allPassMix, 0.5, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \decayLo, 0.01, \decayHi, 1, \glitchSpeed, 20, \delayRandLo, 1, \delayRandHi, 2);

});

	e.add(\2 -> {

	"cue 1".postln;
	c[1].children[1].value_(0);//Off
	c[1].children[2].value_(1);//On
	~hi_sine_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][4], \loop, 1, \gate, 1, \atk, 0.05, \rel, 60, \curve,  -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

	~hi_sine_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][0], \loop, 1, \gate, 1,
				 \atk, 0.05, \rel, 60, \curve, -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

	~sub = Synth(\sub, [\gate, 1, \amp, ~sub_numBox.value, \atk, 0.05, \rel, 60, \curve, -8, \amp, ~sub_numBox.value, \out, ~sub_out]).register;


	~drone_1.set(\gate, 0);
	~drone_2.set(\gate, 0);
	~glitch.set(\gate, 0);




});

	e.add(\3 -> {

	"cue 2".postln;
	c[1].children[2].value_(0);//Off
	c[1].children[3].value_(1);//On

	~hi_sine_1.set(\gate, 0);
	~hi_sine_2.set(\gate, 0);
	~sub.set(\gate, 0);


	~grain_delay = Synth(\glitchy_freeze, [\allPassMix, 1, \pitchMapLo, 0.6 , \pitchMapHi, 1.0, \decayLo, 0.2, \decayHi, 1, \glitchSpeed, 30, \delayRandLo, 0.1, \delayRandHi, 1, \atk, 0.1, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 50, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15], target: ~fx).register;


	~metalPicks = Pdef(
		\metalPicks,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pseg(Pseq([0.01, 0.6], 1), 30, \lin),
			\atk, 0.01,
			\rel, Pif(Ptime(inf) < 2.0, 5.0, 3.0),
			\buf, Pxrand(m[\metal_picks][(0..3)], inf),
			\rate, Pif(Ptime(inf) < 2.0, Pwhite(2.0, 4.0, inf), Pseg(Pseq([2.0, -0.5], 1), 40, \lin)),
			\spos, 0,
			\amp, Pfunc({~sample_streams_val-1.0}),
			\loop, 1,
		    \bpfmix, Pseg(Pseq([0.0, 1.0], 1), 60, \lin),
		    \freq, Pexprand(60, 10000),
		    \rq, Pexprand(0.008, 0.005),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


});





	e.add(\4 -> {

	"cue 3".postln;
	c[1].children[3].value_(0);//Off
	c[1].children[4].value_(1);//On

	~grain_delay.set(\gate, 0);


	~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(2, 4),
			\atk, Pwhite(2, 4),
			\rel, Pwhite(6, 8),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\cringle_2][(0..3)]++m[\cringle_3][(0..3)]++m[\cringle_4][(0..3)]++m[\cringle_5][(0..3)]++m[\cringle_6][(0..3)]++m[\cringle_7][(0..3)]++m[\cringle_8][(0..3)], inf),
			\rate, Pwhite(0.01, 0.8),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 1,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.008, 0.0002),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


});

	e.add(\5 -> {

	"cue 4".postln;
	c[1].children[4].value_(0);//Off
	c[1].children[5].value_(1);//On

		~contact_mic = Synth(\input_2, [\outputbusFX, ~fxBus_contact_mic, \outputbusCV, ~cvBus, \atk, 0.1, \rel, 0.05], target: ~input).register;


		~glitch_2 = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 1, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 7, \brickMod, 10, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 0.2, \decayHi, 1], target: ~fx).register;






});


	e.add(\6 -> {

	c[1].children[5].value_(0);//Off
	c[1].children[6].value_(1);//On

~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(1, 3),
			\atk, Pwhite(2, 4),
			\rel, Pwhite(6, 8),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\cringle_2][(0..3)]++m[\cringle_3][(0..3)]++m[\cringle_4][(0..3)]++m[\cringle_5][(0..3)]++m[\cringle_6][(0..3)]++m[\cringle_7][(0..3)]++m[\cringle_8][(0..3)], inf),
			\rate, Pwhite(0.1, 1),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 0.9,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.008, 0.0002),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


		~glitch_2.set(\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 2, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 7, \brickMod, 12, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 0.7, \decayHi, 2);



});


	e.add(\7 -> {

    c[1].children[6].value_(0);//Off
	c[1].children[7].value_(1);//On


~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(1, 3),
			\atk, Pwhite(2, 4),
			\rel, Pwhite(6, 8),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\cringle_2][(0..3)]++m[\cringle_3][(0..3)]++m[\cringle_4][(0..3)]++m[\cringle_5][(0..3)]++m[\cringle_6][(0..3)]++m[\cringle_7][(0..3)]++m[\cringle_8][(0..3)], inf),
			\rate, Pwhite(0.1, 1),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 0.9,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.08, 0.008),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


		~glitch_2.set(\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 3, \toggleGate, 0, \atk, 30, \delayRandLo, 0.4, \delayRandHi, 7, \brickMod, 15, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 0.7, \decayHi, 2);

		~glitch = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 1, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 20, \brickMult, 0.2, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;
});

	e.add(\8 -> {

	c[1].children[7].value_(0);//Off
	c[1].children[8].value_(1);//On
~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(0.5, 3),
			\atk, Pwhite(2, 4),
			\rel, Pwhite(6, 8),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\cringle_2][(0..3)]++m[\cringle_3][(0..3)]++m[\cringle_4][(0..3)]++m[\cringle_5][(0..3)]++m[\cringle_6][(0..3)]++m[\cringle_7][(0..3)]++m[\cringle_8][(0..3)], inf),
			\rate, Pwhite(0.4, 1),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 0.6,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.8, 0.08),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


		~glitch_2.set(\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 3, \toggleGate, 0, \atk, 30, \delayRandLo, 0.4, \delayRandHi, 7, \brickMod, 16, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 0.7, \decayHi, 2);

		~glitch.set(\allPassMix, 0.5, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \decayLo, 0.01, \decayHi, 1, \glitchSpeed, 10, \delayRandLo, 1, \delayRandHi, 2);


		~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][17], \loop, 1, \gate, 1, \atk, 30, \rel, 0.05, \curve, \lin, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][16], \loop, 1, \gate, 1,
				\atk, 30, \rel, 0.05, \curve, \lin, \rate, 1, \amp, ~sine_tones_numBox.value]).register;


});

	e.add(\9 -> {

	c[1].children[8].value_(0);//Off
	c[1].children[9].value_(1);//On

  ~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(0.1, 1),
			\atk, Pwhite(2, 4),
			\rel, Pwhite(6, 8),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\cringle_2][(0..3)]++m[\cringle_3][(0..3)]++m[\styrofoam][(0..1)], inf),
			\rate, Pwhite(0.4, 1),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 0.2,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.8, 0.08),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


		~glitch_2.set(\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 3, \toggleGate, 0, \atk, 30, \delayRandLo, 0.4, \delayRandHi, 7, \brickMod, 6, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 0.7, \decayHi, 2);

		~glitch.set(\allPassMix, 0.5, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \decayLo, 0.01, \decayHi, 1, \glitchSpeed, 10, \delayRandLo, 1, \delayRandHi, 2);

});

	e.add(\10 -> {

	c[1].children[9].value_(0);//Off
	c[1].children[10].value_(1);//On



	~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pif(Ptime(inf) < 20.0, Pwhite(Pseg(Pseq([0.1, 0.01], inf), Pseq([20.0, 20.0], inf), \linear), Pseg(Pseq([1, 0.02], inf), Pseq([20.0, 20.0], inf), \linear)), Pexprand(0.01, 0.02),inf),

			\atk, Pif(Ptime(inf) < 20.0, Pwhite(Pseg(Pseq([2, 0.01], inf), Pseq([20.0, 20.0], inf), \linear), Pseg(Pseq([4, 0.2], inf), Pseq([20.0, 20.0], inf), \linear)), Pexprand(0.01, 0.2),inf),
			\rel,  Pif(Ptime(inf) < 20.0, Pwhite(Pseg(Pseq([6, 1], inf), Pseq([20.0, 20.0], inf), \linear), Pseg(Pseq([8, 2], inf), Pseq([20.0, 20.0], inf), \linear)), Pexprand(1, 2),inf),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\styrofoam][(0..1)]++m[\metal_picks][(0..3)], inf),
			\rate, Pwhite(0.4, 1),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 0.2,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.8, 0.08),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


		~glitch_2.set(\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 7, \toggleGate, 0, \atk, 30, \delayRandLo, 0.4, \delayRandHi, 2, \brickMod, 10, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 2, \decayHi, 6);

		~glitch.set(\allPassMix, 0.5, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \decayLo, 0.01, \decayHi, 1, \glitchSpeed, 20, \delayRandLo, 0.01, \delayRandHi, 0.5);

});

	e.add(\11 -> {

	c[1].children[10].value_(0);//Off
	c[1].children[11].value_(1);//On

	Routine({
		~cringle.stop;
		s.sync;
		~patterns.free;
		s.sync;
		~patterns = Group.before(~input);
		}).play(AppClock);


Routine({
		~drone_1.set(\gate, 0);
		~drone_2.set(\gate, 0);
		~glitch_2.set(\gate, 0);
		~glitch.set(\gate, 0);
		~contact_mic.set(\gate, 0);


		~hi_sine_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][7], \loop, 1, \gate, 1, \atk, 0.1, \rel, 45, \curve, -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

	~hi_sine_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][6], \loop, 1, \gate, 1,
				 \atk, 0.1, \rel, 45, \curve, -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

			3.wait;

		~hi_sine_1.set(\gate, 0);
		~hi_sine_2.set(\gate, 0);

}).play(AppClock);


});

	e.add(\12 -> {

	c[1].children[11].value_(0);//Off
	c[1].children[12].value_(1);//On


Routine({
	~metalPicks = Pdef(
	\metalPicks,
	Pbind(
		\instrument, \bpfbuf,
					\dur, Pif(Ptime(inf) < 110, Pwhite(Pseg(Pseq([10.0, 0.1], 1), 110, \exp), Pseg(Pseq([15.0, 0.3], 1), 110, \exp)),Pwhite(0.06, 0.2)),
					\atk, Pif(Ptime(inf) < 110, Pwhite(Pseg(Pseq([5, 0.02], 1), 110, \exp), Pseg(Pseq([7, 0.08], 1), 110, \exp)),Pwhite(0.02, 0.08)),
					\rel, Pif(Ptime(inf) < 110, Pwhite(Pseg(Pseq([10, 2.0], 1), 110, \exp), Pseg(Pseq([12, 1.0], 1), 110, \exp)), Pwhite(2.0, 1.5)),
		\buf, Pxrand(m[\metal_picks][(0..3)]++m[\square_rod][(0..2)], inf),
					\rate, Pif(Ptime(inf) < 110, Pbrown(Pseg(Pseq([1, 5], 1), 110, \exp), Pseg(Pseq([1, 10], 1), 110, \exp)), Pwhite(-10, -1)),


	 \spos, Pif(Ptime(inf) < 110, Pwhite(0, Pseg(Pseq([0, 600], 1), 110, \lin)), Pwhite(0, 600)),
		\amp, Pfunc({~sample_streams_val-1.0}),
		\loop, 1,
	    \bpfmix, Pif(Ptime(inf) < 30.0, 1.0, Pseg(Pseq([1.0, 0.0], ), 130, \lin, 1)),
	    \freq, Pexprand(200, 800),
	    \rq, Pexprand(0.008, 0.005),
		\panX, Pwhite(-1.0, 1.0),
		\panY, Pwhite(-1.0, 1.0),
	    \group, ~patterns,
		);
).play(SystemClock);



		2.wait;

		~ring_mod = Synth(\fbMod, [\inputbus, ~fxBus, \outputbusCV, ~cvBus, \atk, 20, \rel, 0.05, \amp, ~ring_mod_numBox.value, \freq, 1000, \fb_start, 0.01, \fb_end, 6.3, \fb_dur, 50], target: ~fx).register;

		}).play(AppClock);


});

	e.add(\13 -> {

	c[1].children[12].value_(0);//Off
	c[1].children[13].value_(1);//On


  ~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][13], \loop, 1, \gate, 1, \atk, 60, \rel, 0.05, \curve, \lin, \rate, 1, \amp, ~sine_tones_numBox.value]).register;



	~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][15], \loop, 1, \gate, 1,
				\atk, 60, \rel, 0.05, \curve, \lin, \rate, 0.6, \amp, ~sine_tones_numBox.value]).register;



});

	e.add(\14 -> {

	c[1].children[13].value_(0);//Off
	c[1].children[14].value_(1);//On


	~glitch = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 2, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 10, \brickMult, 0.6, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;



});

	e.add(\15 -> {

		c[1].children[14].value_(0);//Off
	    c[1].children[15].value_(1);//On


		~glitch.set(\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 2, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 400, \brickMult, 0.8, \amp, ~glitch_numBox.value, \rel, 0.05);



	});

	e.add(\16 -> {
		c[1].children[15].value_(0);//Off
	    c[1].children[16].value_(1);//On

		Routine({

~glitch.set(\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 2, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 400, \brickMult, 0.8, \amp, ~glitch_numBox.value, \rel, 0.05);

		~ring_mod.set(\gate, 0);
	    ~glitch.set(\gate, 0);

		~drone_1.set(\gate, 0);
		~drone_2.set(\gate, 0);


	~sub = Synth(\sub, [\gate, 1, \amp, ~sub_numBox.value, \atk, 0.05, \rel, 15, \curve, -4, \amp, ~sub_numBox.value, \out,~sub_out]).register;


		~metalPicks.stop;

		~overP = Pdef(
				\OverP,
				Pbind(
					\instrument, \bpfbuf,
					\dur, Pwhite(0.001, 0.03),
					\atk, Pexprand(0.02,0.08),
					\rel, Pwhite(0.003, 0.01),
					\buf, Pxrand(m[\over_pressure][(0..2)], inf),
					\rate, 1,
					\spos, Pwhite(0, 1000),
					\amp, Pfunc({~sample_streams_val-3.0}),
					\pan, {Pexprand(-1.0, 1.0)},
					\bpfmix, 0,
					\out, 0,
					\panX, Pwhite(-1.0, 1.0),
					\panY, Pwhite(-1.0, 1.0),
					\group, ~patterns,
				);
			).play(SystemClock);

			~metalPicks_1 = Pdef(
		\metalPicks,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pseg(Pseq([0.01, 0.6], 1), 30, \lin),
			\atk, 0.01,
			\rel, Pif(Ptime(inf) < 2.0, 5.0, 3.0),
			\buf, Pxrand(m[\metal_picks][(0..3)]++m[\styrofoam][(0..1)], inf),
			\rate, Pif(Ptime(inf) < 2.0, Pwhite(2.0, 4.0, inf), Pseg(Pseq([2.0, -0.5], 1), 40, \lin)),
			\spos, 0,
			\amp, Pfunc({~sample_streams_val-1.0}),
			\loop, 1,
		    \bpfmix, Pseg(Pseq([0.0, 1.0], 1), 60, \lin),
		    \freq, Pexprand(60, 10000),
		    \rq, Pexprand(0.008, 0.005),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);

		5.wait;

		~sub.set(\gate, 0);

		15.wait;

	   ~overP.stop;

		}).play(AppClock);

	});

	e.add(\17 -> {
		c[1].children[16].value_(0);//Off
	    c[1].children[17].value_(1);//On

		Routine({
	~glass = Synth(\playbuf_1, [\bufnum1, b[\glass_8][0], \bufnum2, b[\glass_8][1] ,\bufnum3, b[\glass_8][2] ,\bufnum4, b[\glass_8][3], \lpf_freq, 20000, \hpf, 20, \amp, ~glass_numBox.value, \loop, 1], target: ~patterns).register ;

			30.wait;

			~overPressure = Pdef(
		\overPressure,
		Pbind(
			\instrument, \bpfbuf,
			\dur, 10,
			\atk, 5,
			\rel, 10,
			\buf, Pxrand(m[\over_pressure][(0..0)]++m[\styrofoam][(0..0)], inf),
			\rate, Pbrown(0.1, 0.3, 0.01),
			\spos, 0,
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, Pseg(Pseq([0.0, 1.0], inf), inf, \lin),
		    \freq, Pexprand(40, 100),
		    \rq, Pexprand(0.008, 0.005),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play;

		}).play(AppClock);


	});

	e.add(\18 -> {
		c[1].children[17].value_(0);//Off
	    c[1].children[18].value_(1);//On

		~contact_mic = Synth(\input_2, [\outputbusFX, ~fxBus_contact_mic, \outputbusCV, ~cvBus, \atk, 10, \rel, 0.1, \bufnum, b[\square_rod][0]], target: ~input).register;



});

	e.add(\19 -> {
		c[1].children[18].value_(0);//Off
	    c[1].children[19].value_(1);//On


	~stochastic_verb = Synth.new(\reverb2, [\atk, 20, \rel, 0.05, \inputbus_Mic, ~fxBus, \amp, ~stochastic_verb_numBox.value, \trig_start, 0.1, \trig_end, 11.0, \trig_dur, 75], target: ~fx).register;


});

	e.add(\20 -> {
		c[1].children[19].value_(0);//Off
	    c[1].children[20].value_(1);//On

		~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][12], \loop, 1, \gate, 1, \atk, 30, \rel, 0.05, \curve, \exp, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][15], \loop, 1, \gate, 1,
				\atk, 30, \rel, 0.05, \curve, \exp, \rate, 1, \amp, ~sine_tones_numBox.value]).register;





	});

	e.add(\21 -> {
		c[1].children[20].value_(0);//Off
	    c[1].children[21].value_(1);//On
		/*dsp here*/
		//update ~glitch_loops

	~grain_delay = Synth(\glitchy_freeze, [\allPassMix, 1, \pitchMapLo, 0.6 , \pitchMapHi, 1.0, \decayLo, 0.2, \decayHi, 1, \glitchSpeed, 30, \delayRandLo, 0.1, \delayRandHi, 1, \atk, 30, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 50, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 1, \osc_speed, 1], target: ~fx).register;




	});

	e.add(\22 -> {
		c[1].children[21].value_(0);//Off
	    c[1].children[22].value_(1);//On
		/*dsp here*/
		//update ~glitch_loops
		//viola

		~grain_delay.set(\allPassMix, 1, \pitchMapLo, 0.6 , \pitchMapHi, 1.0, \decayLo, 1, \decayHi, 2, \glitchSpeed, 20, \delayRandLo, 0.1, \delayRandHi, 1, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 100, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 1, \osc_speed, 3)


	});

	e.add(\23 -> {
		c[1].children[22].value_(0);//Off
	    c[1].children[23].value_(1);//On
		/*dsp here*/
		//update ~glitch_loops

	~grain_delay.set(\allPassMix, 1, \pitchMapLo, 0.3 , \pitchMapHi, 2.0, \decayLo, 1, \decayHi, 3, \glitchSpeed, 20, \delayRandLo, 0.01, \delayRandHi, 1, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 100, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 1, \osc_speed, 6);



});

	e.add(\24 -> {
		c[1].children[23].value_(0);//Off
	    c[1].children[24].value_(1);//On
		/*dsp here*/
		//update ~glitch_loops


		~grain_delay.set(\allPassMix, 1, \pitchMapLo, 0.3 , \pitchMapHi, 2.0, \decayLo, 1, \decayHi, 3, \glitchSpeed, 20, \delayRandLo, 0.01, \delayRandHi, 1, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 100, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 1, \osc_speed, 12, \rel, 0);
	});

	e.add(\25 -> {
		c[1].children[24].value_(0);//Off
	    c[1].children[25].value_(1);//On
		/*dsp here*/
		//update ~glitch_loops

		Routine({
		~overPressure.stop;
		s.sync;
		~patterns.free;
		s.sync;
		~patterns = Group.before(~input);
		}).play(AppClock);

        ~glass.set(\gate, 0);
		~grain_delay.set(\gate, 0);

		~hi_sine_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][3], \loop, 1, \gate, 1, \atk, 0.05, \rel, 15, \curve, -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

	~hi_sine_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][0], \loop, 1, \gate, 1,
				 \atk, 0.05, \rel, 15, \curve, -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

	~stochastic_verb.set(\gate, 0);

		~drone_1.set(\gate, 0);
	    ~drone_2.set(\gate, 0);


});

	e.add(\26 -> {
		c[1].children[25].value_(0);//Off
	    c[1].children[26].value_(1);//On
		/*dsp here*/
		//update ~glitch_loops

		~ring_mod = Synth(\fbMod, [\inputbus, ~fxBus, \outputbusCV, ~cvBus, \atk, 1, \rel, 0.05, \fb_amount, 6.3, \amp, ~ring_mod_numBox.value, \freq, 400, \fb_start, 6.1, \fb_end, 6.3, \fb_dur, 1], target: ~fx).register;

		~hi_sine_1.set(\gate, 0);
		~hi_sine_2.set(\gate, 0);

		~drone_1 = Synth(\playbuf_4, [\bufnum1, b[\no_input_pulse][0], \loop, 1, \gate, 1, \atk, 0.1, \rel, 0.05, \curve, \exp, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	~drone_2 = Synth(\playbuf_5, [\bufnum1, b[\no_input_pulse][1], \loop, 1, \gate, 1,
				\atk, 0.1, \rel, 0.05, \curve, \exp, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

		~sub = Synth(\sub_1, [\gate, 1, \amp, ~sub_numBox.value, \atk, 0.05, \rel, 0.1, \curve, \lin, \amp, ~sub_numBox.value, \out, ~sub_out, \amDur, 30]).register;


		~contact_mic.set(\gate, 0);

	});

	e.add(\27 -> {
		c[1].children[26].value_(0);//Off
	    c[1].children[27].value_(1);//On
		/*dsp here*/


	~ring_mod.set(\gate, 0);
	~drone_1.set(\gate, 0);
	~drone_2.set(\gate, 0);
	~sub.set(\gate, 0);

~hi_sine_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][4], \loop, 1, \gate, 1, \atk, 0.05, \rel, 30, \curve, -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

	~hi_sine_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][4], \loop, 1, \gate, 1,
				 \atk, 0.05, \rel, 30, \curve, -8, \rate, 1.121, \amp, ~hi_sine_numBox.value, \startPos, 0 ]).register;


	});

	e.add(\28 -> {
		c[1].children[27].value_(0);//Off
	    c[1].children[28].value_(1);//On


		~hi_sine_1.set(\gate, 0);
		~hi_sine_2.set(\gate, 0);



	});

	e.add(\29 -> {
		c[1].children[28].value_(0);//Off
	    c[1].children[29].value_(1);//On

		Routine({
	~glitch = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 1, \toggleGate, 0, \atk, 15, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 20, \brickMult, 0.2, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;

	~glitch_2 = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus_contact_mic, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 1, \toggleGate, 0, \atk, 15, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 20, \brickMult, 0.2, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;

		~contact_mic = Synth(\input_2, [\outputbusFX, ~fxBus_contact_mic, \outputbusCV, ~cvBus, \atk, 10, \rel, 0.1, \bufnum, b[\square_rod][1]], target: ~input).register;


		}).play(AppClock);

	});


	e.add(\30 -> {
		c[1].children[29].value_(0);//Off
	    c[1].children[30].value_(1);//On



		Routine({

		~cringle_1 = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(0.003, 0.005),
			\atk, 0.005,
			\rel, Pwhite(0.2, 1),
			\buf, Pxrand(m[\glass_7][(0..3)], inf),
			\rate, Pxrand([Pwhite(0.5, 20), Pwhite(-0.5, -20)], inf),
			\spos, Pwhite(0.0, 1230000.0),
			\amp, Pfunc({~sample_streams_val+6}),
			\loop, 1,
		    \bpfmix,0,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.008, 0.0002),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);

		~sub = Synth(\sub, [\gate, 1, \amp, ~sub_numBox.value, \atk, 0.1, \rel, 30, \curve, -8, \amp, ~sub_numBox.value, \out, ~sub_out]).register;


		~glitch_2.set(\gate, 0);
		~glitch.set(\gate, 0);

		15.wait;

	   ~sub.set(\gate, 0);

		~cringle_1 = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pif(Ptime(inf) < 15.0, Pwhite(Pseg(Pseq([0.003, 0.2], inf), Pseq([15.0, 15.0], inf), \linear), Pseg(Pseq([0.005, 0.5], inf), Pseq([15.0, 15.0], inf), \linear)), Pexprand(3, 5),inf),
			\atk, 0.005,
			\rel, Pif(Ptime(inf) < 15.0, Pwhite(Pseg(Pseq([1, 3], inf), Pseq([15.0, 15.0], inf), \linear), Pseg(Pseq([3, 5], inf), Pseq([15.0, 15.0], inf), \linear)), Pexprand(2, 5),inf),
			\buf, Pxrand(m[\glass_7][(0..3)]++m[\cringle_1][(0..3)], inf),
			\rate, Pif(Ptime(inf) < 15.0, Pwhite(Pseg(Pseq([-0.5, -0.2], inf), Pseq([15.0, 15.0], inf), \linear), Pseg(Pseq([-20, -0.7], inf), Pseq([15.0, 15.0], inf), \linear)), Pexprand(0.2, 0.7),inf),
			\spos, Pwhite(0.0, 10000.0),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix,0,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.008, 0.0002),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);

	20.wait;

	~cringle_1.stop;


		}).play(AppClock);

});




	e.add(\31 -> {
		c[1].children[30].value_(0);//Off
	    c[1].children[31].value_(1);//On


	~cringle_2 = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pif(Ptime(inf) < 80.0, Pwhite(Pseg(Pseq([0.003, 0.12], inf), Pseq([80.0, 80.0], inf), \linear), Pseg(Pseq([0.005, 0.5], inf), Pseq([80.0, 80.0], inf), \linear)), Pexprand(2, 5),inf),
			\atk, Pif(Ptime(inf) < 80.0, Pwhite(Pseg(Pseq([0.005, 0.5], inf), Pseq([80.0, 80.0], inf), \linear), Pseg(Pseq([0.005, 1], inf), Pseq([80.0, 80.0], inf), \linear)), Pexprand(0.5, 1),inf),
			\rel, Pif(Ptime(inf) < 80.0, Pwhite(Pseg(Pseq([0.2, 2], inf), Pseq([80.0, 80.0], inf), \linear), Pseg(Pseq([1, 5], inf), Pseq([80.0, 80.0], inf), \linear)), Pexprand(2, 5),inf),
			\buf, Pxrand(m[\glass_7][(0..3)]++m[\cringle_1][(0..3)], inf),
			\rate, Pif(Ptime(inf) < 80.0, Pwhite(Pseg(Pseq([0.5, 0.2], inf), Pseq([80.0, 80.0], inf), \linear), Pseg(Pseq([20, 0.7], inf), Pseq([80.0, 80.0], inf), \linear)), Pexprand(0.2, 0.7),inf),
			\spos, Pwhite(0.0, 10000.0),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix,0,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.008, 0.0002),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);

    Routine({
	~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][12], \loop, 1, \gate, 1, \atk, 0.05, \rel, 60, \curve, -8, \rate, 1, \amp, ~sine_tones_numBox.value, \rate, 0.5]).register;

	~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][16], \loop, 1, \gate, 1,
				\atk, 0.05, \rel, 60, \curve, -8, \rate, 0.7, \amp, ~sine_tones_numBox.value]).register;


			~sub_1 = Synth(\sub_1, [\gate, 1, \amp, ~sub_numBox.value, \atk, 0.05, \rel, 90, \curve, -8, \amp, ~sub_numBox.value, \out, ~sub_out, \amDur, 30]).register;



	        2.wait;


			~drone_1.set(\gate, 0);
			~drone_2.set(\gate, 0);
			~sub_1.set(\gate, 0);


		}).play(AppClock);

	~stochastic_verb = Synth.new(\reverb2, [\atk, 0.1, \rel, 30, \inputbus_Mic, ~fxBus, \amp, ~stochastic_verb_numBox.value, \trig_start, 11, \trig_end, 0.1, \trig_dur, 75, \curve, -4], target: ~fx).register;

		~grain_delay = Synth(\glitchy_freeze, [\allPassMix, 1, \pitchMapLo, 1.0 , \pitchMapHi, 1.2, \decayLo, 2, \decayHi, 10, \glitchSpeed, 30, \delayRandLo, 0.01, \delayRandHi, 3, \gate, 1, \inputbus_Mic, ~fxBus_contact_mic, \brickMod, 100, \brickMult, 0, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 0, \osc_speed, 20], target: ~fx).register;




	});

	e.add(\32 -> {
		c[1].children[31].value_(0);//Off
	    c[1].children[32].value_(1);//On

		~grain_delay.set(\allPassMix, 1, \pitchMapLo, 1.0 , \pitchMapHi, 1.2, \decayLo, 0.2, \decayHi,4, \glitchSpeed, 13, \delayRandLo, 0.1, \delayRandHi, 3, \gate, 1, \inputbus_Mic, ~fxBus_contact_mic, \brickMod, 30, \brickMult, 0, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 0.2, \osc_speed, 3);

});

	e.add(\33 -> {
			c[1].children[32].value_(0);//Off
	    c[1].children[33].value_(1);//On

		~grain_delay.set(\allPassMix, 1, \pitchMapLo, 1.0 , \pitchMapHi, 1.2, \decayLo, 0.2, \decayHi,4, \glitchSpeed, 6, \delayRandLo, 0.1, \delayRandHi, 3, \gate, 1, \inputbus_Mic, ~fxBus_contact_mic, \brickMod, 30, \brickMult, 0, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 0.6, \osc_speed, 3);

		~ring_mod = Synth(\fbMod, [\inputbus, ~fxBus, \outputbusCV, ~cvBus, \atk, 10, \rel, 0.05, \fb_Amount, 0, \amp, ~ring_mod_numBox.value, \freq, 4000, \fb_start, 0.01, \fb_end, 6.3, \fb_dur, 45], target: ~fx).register;

		~stochastic_verb.set(\gate, 0);
});

	e.add(\34 -> {
		c[1].children[33].value_(0);//Off
	    c[1].children[34].value_(1);//On

Routine({
		~grain_delay.set(\allPassMix, 1, \pitchMapLo, 1.0 , \pitchMapHi, 1.2, \decayLo, 0.2, \decayHi,4, \glitchSpeed, 3, \delayRandLo, 0.1, \delayRandHi, 3, \gate, 1, \inputbus_Mic, ~fxBus_contact_mic, \brickMod, 30, \brickMult, 0, \amp, ~grain_delay_numBox.value, \rel, 0.05, \amMix, 1, \osc_speed, 3);

		~drone_3 = Synth(\playbuf_6, [\bufnum1, b[\last_drone][0], \bufnum2, b[\last_drone][1] ,\bufnum3, b[\last_drone][2] ,\bufnum4, b[\last_drone][3], \lpf_freq, 20000, \hpf, 20, \amp,  ~sine_tones_numBox.value, \loop, \atk, 45, \curve, -8, \rel, 0.05], target: ~patterns).register;

		15.wait;

		~contact_mic.set(\gate, 0);

		5.wait;

		 ~cringle_2.stop;

		10.wait;

		~grain_delay.set(\gate, 0);

		}).play(AppClock);
	});

	e.add(\35 -> {
		c[1].children[34].value_(0);//Off
	    c[1].children[35].value_(1);//On

		~ring_mod.set(\gate, 0);
		~viola.set(\gate, 0);
		~drone_3.set(\gate, 0, \rel, ~viola_fx_rel);
	});


};



//6. Make GUI
// GUI////////////////////////////////////////////////////////////////////////////////
~makeGui = {
Window.closeAll;
w = Window("Falter/Cleanse", Rect(750,50,1200,600))
.front
.alwaysOnTop_(true);

// Composite View 0//////////////
StaticText(w, Rect(0,0,580,40))
.string_("Falter/Cleanse")
.align_(\center)
.front
.stringColor_(Color(1, 1, 1))
.font_(Font(size: 30));

StaticText(w, Rect(0,35,580,40))
.string_("By Hunter Brown")
.align_(\center)
.front
.stringColor_(Color(1, 1, 1))
.font_(Font(size: 30));

// Composite View 1//////////////
StaticText(w, Rect(602,5,580,30))
.string_("Rehearsal Cues")
.align_(\center)
.front
.stringColor_(Color(1, 1, 1))
.font_(Font(size: 30));

// Composite View 2//////////////


StaticText(w, Rect(0,200,70,30))
.string_("Glass")
.align_(\center)
.front
.font_(Font(size: 15));



StaticText(w, Rect(120,200,70,30))
.string_("Hi Tones")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(240,200,70,30))
	.string_("Sub")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(351,200,90,30))
.string_("HPF")
.align_(\center)
.front
.font_(Font(size: 15));



StaticText(w, Rect(400,370,70,30))
.string_("hz")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(280,370,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(160,370,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(40,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(400,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(280,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(160,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

//
StaticText(w, Rect(640,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(520,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(760,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(880,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));


StaticText(w, Rect(0,400,75,30))
.string_("Dry Viola")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(110,400,100,30))
.string_("Contact Mic")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(215,400,120,30))
.string_("Glitch")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(348,400,100,30))
.string_("Grain Delay")
.align_(\center)
.front
.font_(Font(size: 15));


StaticText(w, Rect(460,400,110,30))
	.string_("Ring Mod")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(580,400,110,30))
.string_("Stoc Verb")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(700,400,110,30))
.string_("Algo Samples")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(819,400,110,30))
.string_("Drones")
.align_(\center)
.front
.font_(Font(size: 15));







/*
StaticText(w, Rect(950,200,200,200))
.string_("Sine Tones")
.align_(\center)
.front
.font_(Font(size: 30));
*/




w.view.decorator_(FlowLayout(w.bounds, 0@0, 0@0));

// composite views
c = Array.fill( 6, {
	arg view;
	view = CompositeView(w, 600@200)
	.background_();

	view.decorator_(FlowLayout(view.bounds, 10@25, 70@0));
});
//Fills the various composite views
c[0].background_(Color(0, 0, 0));
c[0].decorator_(FlowLayout(c[0].bounds, 90@40, 15@15)); // Array 0
c[0].decorator.nextLine;
c[0].decorator.nextLine;
c[0].decorator.nextLine;
Array.fill(1, {Button(c[0], 200@50).font_(Font(size: 30)).states_([["Initialization", Color.black, Color.gray(0.8)],["Initialized", Color.white, Color(0,0,0)]])}); //Dry Strings: Array 0

Array.fill(1, {Button(c[0], 200@50).font_(Font(size: 30)).states_([["Stop & Reset", Color.black, Color.gray(0.8)]])});

c[0].decorator.nextLine;
c[0].decorator_(FlowLayout(c[0].bounds, 190@140, 15@15)); // Array 0
Array.fill(1, {Button(c[0], 200@50).font_(Font(size: 30)).states_([["Cue", Color.black, Color.gray(0.8)]])}); //Dry Strings: Array 0


c[1].background_(Color(0, 0, 0));
c[1].decorator_(FlowLayout(c[0].bounds, 15@15, 10@15)); // Array 1
c[1].decorator.nextLine;
c[1].decorator.nextLine;
Array.fill(36, {
		arg i=(-1);
		{i = i + 1};
		Button(c[1], 35@35).states_([[i.asString, Color.black, Color.gray(0.8)],[i.asString, Color.white, Color(0,0,0)]])});//Dry Strings: Array 0

c[2].background_(Color(1, 1, 1));
c[3].background_(Color(1, 1, 1));
c[4].background_(Color(1, 1, 1));
c[5].background_(Color(1, 1, 1));


Array.fill(4, {Slider(c[2], 50@150)});//Dry Strings: Array 2
c[2].decorator.nextLine;
Array.fill(4, {NumberBox(c[2], 50@20)}); //Dry Strings: Array 2


Array.fill(5, {Slider(c[4], 50@150)}); //Samples (Grain Buf, PLayBuf): Array 3
c[4].decorator.nextLine;
Array.fill(5, {NumberBox(c[4], 50@20)});


Array.fill(3, {Slider(c[5], 50@150)}); //Samples (Grain Buf, PLayBuf): Array 3
c[5].decorator.nextLine;
Array.fill(3, {NumberBox(c[5], 50@20)});



//Controls/////////////////////////////////////////////////
//Compositie View 0 Dry Strings/////////////////////////////////////////////////
c[2].children[0].valueAction_(-60.0);
c[2].children[1].valueAction_(-60.0);
c[2].children[2].valueAction_(-60.0);
c[2].children[3].valueAction_(-60.0);
c[2].children[4].valueAction_(-60.0);
c[2].children[5].valueAction_(-60.0);
c[2].children[6].valueAction_(-60.0);
c[2].children[7].valueAction_(-60.0);


c[4].children[0].valueAction_(-60.0);
c[4].children[1].valueAction_(-60.0);
c[4].children[2].valueAction_(-60.0);
c[4].children[3].valueAction_(-60.0);
c[4].children[4].valueAction_(-60.0);
c[4].children[5].valueAction_(-60.0);
c[4].children[6].valueAction_(-60.0);
c[4].children[7].valueAction_(-60.0);
c[4].children[8].valueAction_(-60.0);
c[4].children[9].valueAction_(-60.0);

c[5].children[0].valueAction_(-60.0);
c[5].children[1].valueAction_(-60.0);
c[5].children[2].valueAction_(-60.0);
c[5].children[3].valueAction_(-60.0);
c[5].children[4].valueAction_(-60.0);
c[5].children[5].valueAction_(-60.0);



~init_button = c[0].children[0]
.action_({
	arg obj;
	if(obj.value == 1, {e[\init].value;"init".postln},{nil});
});

~stop_button = c[0].children[1]
	.mouseDownAction_({e[\stop_reset].value})

	.mouseUpAction_({~init_button.valueAction = 0});

~next_cue_button = c[0].children[2]
.mouseDownAction_({e[~cue.asSymbol].value;
})
.mouseUpAction_({
		//arg obj;
		//if(obj.value == 1, {~cue = ~cue + 1.postln},{nil});
		~cue = ~cue + 1;
});

~rehearsal_cue_button_0 = c[1].children[0]
.mouseDownAction_({
		~cue=0;
});

~rehearsal_cue_button_1 = c[1].children[1]
.mouseDownAction_({
		~cue=1;
});

~rehearsal_cue_button_2 = c[1].children[2]
.mouseDownAction_({
		~cue=2;
});

~rehearsal_cue_button_3 = c[1].children[3]
.mouseDownAction_({
		~cue=3;
});

~rehearsal_cue_button_4 = c[1].children[4]
.mouseDownAction_({
		~cue=4;
});

~rehearsal_cue_button_5 = c[1].children[5]
.mouseDownAction_({
		~cue=5;
});

~rehearsal_cue_button_6 = c[1].children[6]
.mouseDownAction_({
		~cue=6;
});

~rehearsal_cue_button_7 = c[1].children[7]
.mouseDownAction_({
		~cue=7;
});


~rehearsal_cue_button_8 = c[1].children[8]
.mouseDownAction_({
		~cue=8;
});

~rehearsal_cue_button_9 = c[1].children[9]
.mouseDownAction_({
		~cue=9;
});

~rehearsal_cue_button_10 = c[1].children[10]
.mouseDownAction_({
		~cue=10;
});

~rehearsal_cue_button_11 = c[1].children[11]
.mouseDownAction_({
		~cue=11;
});

~rehearsal_cue_button_12 = c[1].children[12]
.mouseDownAction_({
		~cue=12;
});

~rehearsal_cue_button_13 = c[1].children[13]
.mouseDownAction_({
		~cue=13;
});

~rehearsal_cue_button_14 = c[1].children[14]
.mouseDownAction_({
		~cue=14;
});

~rehearsal_cue_button_15 = c[1].children[15]
.mouseDownAction_({
		~cue=15;
});

~rehearsal_cue_button_16 = c[1].children[16]
.mouseDownAction_({
		~cue=16;
});

~rehearsal_cue_button_17 = c[1].children[17]
.mouseDownAction_({
		~cue=17;
});

~rehearsal_cue_button_18 = c[1].children[18]
.mouseDownAction_({
		~cue=18;
});

~rehearsal_cue_button_19 = c[1].children[19]
.mouseDownAction_({
		~cue=19;
});


~rehearsal_cue_button_20 = c[1].children[20]
.mouseDownAction_({
		~cue=20;
});

~rehearsal_cue_button_21 = c[1].children[21]
.mouseDownAction_({
		~cue=21;
});

~rehearsal_cue_button_22 = c[1].children[22]
.mouseDownAction_({
		~cue=22;
});

~rehearsal_cue_button_23 = c[1].children[23]
.mouseDownAction_({
		~cue=23;
});

~rehearsal_cue_button_24 = c[1].children[24]
.mouseDownAction_({
		~cue=24;
});

~rehearsal_cue_button_25 = c[1].children[25]
.mouseDownAction_({
		~cue=25;
});

~rehearsal_cue_button_26 = c[1].children[26]
.mouseDownAction_({
		~cue=26;
});

~rehearsal_cue_button_27 = c[1].children[27]
.mouseDownAction_({
		~cue=27;
});

~rehearsal_cue_button_28 = c[1].children[28]
.mouseDownAction_({
		~cue=28;
});

~rehearsal_cue_button_29 = c[1].children[29]
.mouseDownAction_({
		~cue=29;
});

~rehearsal_cue_button_30 = c[1].children[30]
.mouseDownAction_({
		~cue=30;
});

~rehearsal_cue_button_31 = c[1].children[31]
.mouseDownAction_({
		~cue=31;
});

~rehearsal_cue_button_32 = c[1].children[32]
.mouseDownAction_({
		~cue=32;
});

~rehearsal_cue_button_33 = c[1].children[33]
.mouseDownAction_({
		~cue=33;
});

~rehearsal_cue_button_34 = c[1].children[34]
.mouseDownAction_({
		~cue=34;
});


~rehearsal_cue_button_35 = c[1].children[35]
.mouseDownAction_({
		~cue=35;
});


~glass_slider = c[2].children[0]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60, 1);
		if(~glass.isPlaying,
	{~glass.set(\amp, amp)}
);
~glass_numBox.value_(obj.value.linlin(0.0,1.0,-60, 1)); // updates numberbox with freq information.
});
~glass_numBox = c[2].children[4]
.decimals_(1)
.clipLo_(-60)
.clipHi_(0.0)
.action_({
	arg obj;
~glass_slider.valueAction_(obj.value.linlin(-60, 1, 0.0,1.0))
});


~hi_sine_slider = c[2].children[1]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~hi_sine_1.isPlaying,
	{~hi_sine_1.set(\amp, amp)}
);

	if(~hi_sine_2.isPlaying,
	{~hi_sine_2.set(\amp, amp)}
);

	~hi_sine_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});
~hi_sine_numBox = c[2].children[5]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~hi_sine_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~sub_slider = c[2].children[2]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~sub.isPlaying,
			{~sub.set(\amp, amp)});

    if(~sub_1.isPlaying,
			{~sub_1.set(\amp, amp)});



	~sub_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});
~sub_numBox = c[2].children[6]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~sub_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~delay_feedback_slider = c[2].children[3]
.action_({
	arg obj;
	var hpf_freq;
	hpf_freq = obj.value.linlin(0.0,1.0,30.0,100.0);
		if(~viola.isPlaying,
	{~viola.set(\hpf_freq, hpf_freq)}
);

	if(~contact_mic.isPlaying,
	{~contact_mic.set(\hpf_freq, hpf_freq)}
);
~delay_feedback_numBox.value_(obj.value.linlin(0.0,1.0,30.0,100.0)); // updates numberbox with freq information.
});
~delay_feedback_numBox = c[2].children[7]
.decimals_(1)
.clipLo_(30.0)
.clipHi_(100.0)
.action_({
	arg obj;
~delay_feedback_slider.valueAction_(obj.value.linlin(30.0,100.0, 0.0,1.0))
});


~viola_slider = c[4].children[0].action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0, -60.0,0.0);
	if(~viola.isPlaying,
	{~viola.set(\amp, amp)}
);
	~viola_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});

~viola_numBox = c[4].children[5]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~viola_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0)) // allows you to move slider via typing numbers
});

~contact_mic_slider = c[4].children[1]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~contact_mic.isPlaying,
	{~contact_mic.set(\amp, amp)}
);



~contact_mic_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});
~contact_mic_numBox = c[4].children[6]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
~contact_mic_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~glitch_slider = c[4].children[2].action_({
	arg obj;
		var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0, 5.0);
	if(~glitch.isPlaying,
	{~glitch.set(\amp, amp)}

);

	if(~glitch_2.isPlaying,
	{~glitch_2.set(\amp, amp)}

);
	~glitch_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,5.0)); // updates numberbox with freq information.
});

~glitch_numBox = c[4].children[7]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(5.0)
.action_({
	arg obj;
	~glitch_slider.valueAction_(obj.value.linlin(-60.0,5.0, 0.0,1.0)) // allows you to move slider via typing numbers
});


~grain_delay_slider = c[4].children[3]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~grain_delay.isPlaying,
	{~grain_delay.set(\amp, amp)}
);
	~grain_delay_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});
~grain_delay_numBox = c[4].children[8]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~grain_delay_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0)) // allows you to move slider via typing numbers
});

~ring_mod_slider = c[4].children[4]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~ring_mod.isPlaying,
	{~ring_mod.set(\amp, amp)}
);
	~ring_mod_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});
~ring_mod_numBox = c[4].children[9]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~ring_mod_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0)) // allows you to move slider via typing numbers
});


~stochastic_verb_slider = c[5].children[0]
.action_({
	arg obj;
	var amp;
	~stochastic_verb_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.

		amp = obj.value.linlin(0.0,1.0,-60.0,-0.0);

		if(~stochastic_verb.isPlaying,
	{~stochastic_verb.set(\amp, amp)}
);
});
~stochastic_verb_numBox = c[5].children[3]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~stochastic_verb_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~sample_streams_slider = c[5].children[1]
.action_({
	arg obj;
	var amp;
	~sample_streams_val = obj.value.linlin(0.0,1.0,-60.0,0.0);

	~sample_streams_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});
~sample_streams_numBox = c[5].children[4]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~sample_streams_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});


~sine_tones_slider = c[5].children[2]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~drone_1.isPlaying,
	{~drone_1.set(\amp, amp)}
);

	if(~drone_2.isPlaying,
	{~drone_2.set(\amp, amp)}
);


	if(~drone_3.isPlaying,
	{~drone_3.set(\amp, amp)}
);

	~sine_tones_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0)); // updates numberbox with freq information.
});
~sine_tones_numBox = c[5].children[5]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~sine_tones_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

};

//7. Make CleanUp
~cleanup = { // kills all processes on server quit
	s.newBusAllocators;
	ServerBoot.removeAll;
	ServerTree.removeAll;
	ServerQuit.removeAll;
};



ServerBoot.add(~makeGui);
ServerBoot.add(~makeBuffers); // "ServerBoot" happens when server boots.
ServerQuit.add(~cleanup); // "ServerQuit" happens when server is Quit.

//9. Make Busses & SynthDefs /////////////////////////////////////////////////////////////////////////////////////////////////////////

s.waitForBoot({ // Wait to boot server once contained functions have been evaluated.




	s.sync;

	    ~fxBus = Bus.audio(s, 2);
		~samplesBus = Bus.audio(s, 2);
		~emptyBus = Bus.audio(s, 2);
		~verbSend = Bus.audio(s, 2);
		~reverbOut = Bus.audio(s, 2);
		~reverbIn = Bus.audio(s, 2);
		~inputbus1 = Bus.audio(s, 2);
		~inputamp =  Bus.audio(s, 1);
		~cvBus = Bus.audio(s, 1);
		~cvBusSend =  Bus.control(s, 1);
		~sineModBus = Bus.audio(s, 2);
	    ~fxBus_contact_mic = Bus.audio(s, 1);


	s.sync;


SynthDef(\bpfbuf, {
		arg atk=0, sus=0, rel=3, c1=1, c2=(-1),
		buf=0, rate=1, spos=0, freq=440, rq=1, bpfmix=0,
		panX=0, panY=0, amp=0.0, out=~inputbus1, loop=1,
	    combmix=0, delayTime=0.2, decayTime=1.0;
		var sig, env;
		env = EnvGen.kr(Env([0.0,1.0,1.0,0.0],[atk,sus,rel],[c1,0,c2]),doneAction:2);
		sig = PlayBuf.ar(1, buf, rate*BufRateScale.ir(buf), startPos:spos, loop: loop);
	    sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), (bpfmix*2-1));
	    sig = sig * env;
		sig = Pan4.ar(sig, panX, panY);
		Out.ar(out, sig * amp.dbamp.lag(0.1));
}).add;


// Input
SynthDef(\input_1, {
		arg amp=(-60), gate=1, outputbusCV=~cvBus, outputbusFX=~fxBus,
	inputbus, rel=30, atk=0.005, sus=0, dryamp=0.2, fb=0, modeEnd, modStart, bufnum, hpf_freq=30;
	var in, env, sig, modIn, mult, modFreq=131, sine, temp, modMix, changeTime=0.1;
	in = SoundIn.ar(~micchannel_1);
	//in = PlayBuf.ar(1, bufnum, 1, 1, 0, 1);
	env = EnvGen.kr(Env.adsr(0.1, 0.1, 1, 0.1, 1.0), gate, doneAction:2);
	sig = env * in * amp.dbamp.lag(0.1);
	in = in * env;

	Out.ar(outputbusFX, in);// to processing
	Out.ar(outputbusCV, in);// to cv
		Out.ar([0,1], HPF.ar(sig, hpf_freq.lag(0.1)));// dry
}).add;

SynthDef(\input_2, {
	arg amp=(-60), gate=1, outputbusCV=~cvBus, outputbusFX=~fxBus,
	inputbus, rel=30, atk=0.005, sus=0, dryamp=0.2, fb=0, modeEnd, modStart, bufnum;
	var in, env, sig, modIn, mult, modFreq=131, sine, temp, modMix, changeTime=0.1, hpf_freq=30;
	in = SoundIn.ar(~micchannel_2);
	//in = PlayBuf.ar(1, bufnum, 1, 1, 0, 1);
	env = EnvGen.kr(Env.adsr(0.1, 0.1, 1.0, 0.1, 1.0), gate, doneAction:2);
	sig = env * in * amp.dbamp.lag(0.1);
	in = in * env;
	Out.ar(outputbusFX, in);// to processing
	Out.ar(outputbusCV, in);// to cv
	Out.ar([0,1], sig);// dry
}).add;


// Amplitude Tracking **~outputamp** sends amplitude data

SynthDef(\amptracking, {
	arg outputbus=~cvBusSend, inputbus=~cvBus;
	var sig, in;
	in = In.ar(inputbus, 1);
	sig = RMS.kr(in).linlin(0.0, 0.2, 0.0, 1.0);
	Out.kr(outputbus, sig);
}).add;


//Glitchy freeze // Change buffer? modify freeze. not stock. or LPF. or 2k FM.
SynthDef(\glitchy_freeze, {
	arg out=0, buffer=~fftBuff, allPassMix=1, glitchSpeed=20,
	cvbus, atk=10, sus=1, rel=60, gate=1, inputbus_Mic=~outputBusMicFX,
	max=0.4, delay=0.2, decay=2, toggleGate=0, amp=~slider1.value ,
	pitchMapLo = 0.25 ,pitchMapHi = 4.0, delayRandLo = 20,
	delayRandHi = 40, decayLo = 2, decayHi = 30, envCurve =  1, brickMod=10, brickMult = 1, amMix=0, osc_speed =1;

    var in, chain, trig, sig, impulse, cvin, env, temp, freeze, delaySig, gateEnv;
	delaySig = 0;

	in = In.ar(inputbus_Mic, 1);
	cvin = In.kr(cvbus, 1);
	impulse = Dust.kr(glitchSpeed);
	trig = ToggleFF.kr(impulse).linlin(0, 1, toggleGate, 1);
	env = EnvGen.kr(Env.adsr(atk, 1, sus, rel, curve: envCurve), gate, doneAction:2);
    chain = FFT(buffer, in);
	chain = PV_BrickWall(chain, LFNoise1.kr(brickMod, brickMult));
	chain = PV_BinShift(chain, cvin.linlin(0.2, 0.6, pitchMapLo, pitchMapHi));
	chain = PV_MagFreeze(chain, trig);
	freeze = IFFT(chain).dup;
	temp = DelayN.ar(temp, 0,2, 0.1, mul: 1);
	5.do{
		temp = AllpassC.ar(freeze,
			LFNoise2.kr(cvin.exprange(delayRandLo,delayRandHi)).exprange({Rand(0.01,0.2)}, {Rand(0.2,0.5)}),
			LFNoise2.kr(cvin.exprange(delayRandLo,delayRandHi)).exprange({Rand(0.01,0.2)}, {Rand(0.2,0.5)})!2,
			LFNoise2.kr(cvin.exprange(delayRandLo,delayRandHi)).linlin(0, 1.0, decayLo, decayHi));
			delaySig = delaySig + temp;
		};
	sig = XFade2.ar(freeze, delaySig ,allPassMix*2-1);
	sig = sig * env;
	sig  = XFade2.ar(sig, sig * SinOsc.kr(osc_speed).linlin(-1.0, 1.0, 0.0, 1.0), amMix*2-1);
	Out.ar(out, sig*amp.dbamp.lag(0.1));
 }).add;

	SynthDef(\fbMod, {
	arg amp=0.5, gate=1, outputbusCV=~cvBus, outputbusFX=~fxBus,
	inputbus, rel=30, atk=0.005, sus=0.5, dryamp=0.2, fb=0, modeEnd, modStart, out=0, changeTime=0.1, startAmount = 0.0, endAmount = 1.0, decay=0.3, fb_amount=0.0, freq=300, fb_start, fb_end, fb_dur;
	var in, env, sig, modIn, mult, modFreq=131, sine, temp, modMix;
	sig = In.ar(inputbus)!2;
	env = EnvGen.kr(Env.adsr(atk, decay, sus, rel, sustainLevel: 1.0), gate, doneAction:2);
		sig = sig * SinOscFB.ar(freq, XLine.kr(fb_start, fb_end, fb_dur), 1.0);
	sig = env * sig * amp.dbamp.lag(0.1);
	Out.ar(outputbusFX, sig);// to processing
	Out.ar(out, sig);
}).add;



// Small Verb Changing

SynthDef(\reverb2, {
		arg inputbus_Mic=~fxBus, inputbus_Samples = ~reverbIn, predelay=0.1, revtime=1.8,
		lpf=4500, mix=1, amp=1, out=0, sendsOut=~reverbOut, gate=1, atk=0, sus=1, rel=6, c1=1, c2=(-1), changeTime = 50, startAmount=30, endAmount=0.5, trig_start, trig_end, trig_dur;
		var dry, wet, temp, sig, env, temp1, trig1, trig2;
		dry = In.ar(inputbus_Mic,1);
	    temp1 = In.ar(~verbSend,1);
	    temp = dry + temp1;
	    env = EnvGen.kr(Env.adsr(atk, 0.3, sus, rel, 0.3, \lin), gate, doneAction:2);
		wet = 0;
	    trig1 = Dust.kr(XLine.kr(trig_start, trig_end, trig_dur));
		trig2 = Dust.kr(XLine.kr(trig_start, trig_end, trig_dur));
		temp = DelayN.ar(temp, 0,2, predelay, mul: 3);
		20.do{
		temp = AllpassL.ar(temp, {Rand(0.001,0.02)}, {TRand.kr(0.001,0.02, trig1)}, {TRand.kr(0.01, 0.3, trig2)});
			temp = LPF.ar(temp, {TRand.kr(1000, 6000, trig1)});
			Out.ar({IRand(0, ~channelAmount)}, Limiter.ar(HPF.ar(temp*amp.dbamp.lag(0.1)*env, 100), 0.9));
		};
}).add;


	SynthDef(\playbuf_1, {
		arg bufnum1, bufnum2, bufnum3, bufnum4,  rate=1, trig, startPos=0, loop=1, amp=(-20), atk=0.05, dec=0.1, sus=1, rel=0.05, curve= (-8), gate=1, high_pass_freq=900, low_pass_freq=100, low_pass_mix=0, high_pass_mix=0, hpf_freq=20, lpf_freq=22000, fb_Mix, line_dur=60;
		var sig1,sig2, sig3, sig4, env;
		sig1 = PlayBuf.ar(1, bufnum1, Line.kr(1, 1, line_dur), trig, startPos, loop);
		sig2 = PlayBuf.ar(1, bufnum2, Line.kr(1, 0.98, line_dur), trig, startPos, loop);
		sig3 = PlayBuf.ar(1, bufnum3, Line.kr(1, 1.01, line_dur), trig, startPos, loop);
		sig4 = PlayBuf.ar(1, bufnum4, Line.kr(1, 1.2, line_dur), trig, startPos, loop);
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig1 = LPF.ar(sig1 * env * amp.dbamp.lag(0.1), lpf_freq);
		sig2 = LPF.ar(sig2 * env * amp.dbamp.lag(0.1), lpf_freq);
		sig3 = LPF.ar(sig3 * env * amp.dbamp.lag(0.1), lpf_freq);
		sig4 = LPF.ar(sig4 * env * amp.dbamp.lag(0.1), lpf_freq);
		sig1 = HPF.ar(sig1, hpf_freq);
		sig2 = HPF.ar(sig2, hpf_freq);
		sig3 = HPF.ar(sig3, hpf_freq);
		sig4 = HPF.ar(sig4, hpf_freq);
		sig1 =XFade2.ar(sig1, sig1 * SinOscFB.ar({Rand(300, 2000)}, Line.kr(0, 7, 140), Line.kr(0, 1, 140)*2-1));
		sig2 =XFade2.ar(sig2, sig2 * SinOscFB.ar({Rand(300, 2000)}, Line.kr(0, 7, 140), Line.kr(0, 1, 140)*2-1));
	    sig3 =XFade2.ar(sig3, sig4 * SinOscFB.ar({Rand(300, 2000)}, Line.kr(0, 7, 140), Line.kr(0, 1, 140)*2-1));
		sig4 =XFade2.ar(sig4, sig4 * SinOscFB.ar({Rand(300, 2000)}, Line.kr(0, 7, 140), Line.kr(0, 1, 140)*2-1));
		Out.ar(0, sig1);
		Out.ar(1, sig2);
	    Out.ar(2, sig3);
		Out.ar(3, sig4);
	}).add;

	SynthDef(\playbuf_6, {
		arg bufnum1, bufnum2, bufnum3, bufnum4,  rate=1, trig, startPos=0, loop=1, amp=(-20), atk=0.05, dec=0.1, sus=1, rel=0.05, curve= (-8), gate=1, high_pass_freq=900, low_pass_freq=100, low_pass_mix=0, high_pass_mix=0, hpf_freq=20, lpf_freq=22000, fb_Mix, line_dur=60;
		var sig1,sig2, sig3, sig4, env;
		sig1 = PlayBuf.ar(1, bufnum1,1 , trig, startPos, loop);
		sig2 = PlayBuf.ar(1, bufnum2, 1, trig, startPos, loop);
		sig3 = PlayBuf.ar(1, bufnum3, 1, trig, startPos, loop);
		sig4 = PlayBuf.ar(1, bufnum4, 1, trig, startPos, loop);
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig1 = LPF.ar(sig1  * amp.dbamp.lag(0.1), lpf_freq);
		sig2 = LPF.ar(sig2 * amp.dbamp.lag(0.1), lpf_freq);
		sig3 = LPF.ar(sig3 * amp.dbamp.lag(0.1), lpf_freq);
		sig4 = LPF.ar(sig4  * amp.dbamp.lag(0.1), lpf_freq);
		sig1 = HPF.ar(sig1, hpf_freq);
		sig2 = HPF.ar(sig2, hpf_freq);
		sig3 = HPF.ar(sig3, hpf_freq);
		sig4 = HPF.ar(sig4, hpf_freq);
		Out.ar(0, sig1* env);
		Out.ar(1, sig2* env);
	    Out.ar(2, sig3* env);
		Out.ar(3, sig4* env);
	}).add;





    SynthDef(\playbuf_2, {
		arg bufnum1, bufnum2,  rate=1, trig, startPos=0, loop=1, amp=(-20), atk=0.05, dec=0.1, sus=1, rel=0.05, curve= (-2), gate=1, high_pass_freq=900, low_pass_freq=100, low_pass_mix=0, high_pass_mix=0, hpf_freq=20, lpf_freq=22000;
		var sig1,sig2, env;
		sig1 = PlayBuf.ar(2, bufnum1, rate, trig, startPos, loop);
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig1 = LPF.ar(sig1 * env * amp.dbamp.lag(0.1), lpf_freq);
		Out.ar(0, HPF.ar(sig1, hpf_freq));
	}).add;

	  SynthDef(\playbuf_3, {
		arg bufnum1, bufnum2,  rate=1, trig, startPos=0, loop=1, amp=(-20), atk=0.05, dec=0.1, sus=1, rel=0.05, curve= (-2), gate=1, high_pass_freq=900, low_pass_freq=100, low_pass_mix=0, high_pass_mix=0, hpf_freq=20, lpf_freq=22000;
		var sig1,sig2, env;
		sig1 = PlayBuf.ar(2, bufnum1, rate, trig, startPos, loop);
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig1 = LPF.ar(sig1 * env * amp.dbamp.lag(0.1), lpf_freq);
		Out.ar(2, HPF.ar(sig1, hpf_freq));
	}).add;



    SynthDef(\playbuf_4, {
		arg bufnum1, bufnum2,  rate=1, trig, startPos=0, loop=1, amp=(-20), atk=0.05, dec=0.1, sus=1, rel=0.05, curve= (-2), gate=1, high_pass_freq=900, low_pass_freq=100, low_pass_mix=0, high_pass_mix=0, hpf_freq=20, lpf_freq=22000;
		var sig1,sig2, env;
		sig1 = PlayBuf.ar(2, bufnum1, rate, trig, startPos, loop);
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig1 = LPF.ar(sig1 * env * amp.dbamp.lag(0.1), lpf_freq);
		Out.ar([0,2], HPF.ar(sig1, hpf_freq));
	}).add;

	  SynthDef(\playbuf_5, {
		arg bufnum1, bufnum2,  rate=1, trig, startPos=0, loop=1, amp=(-20), atk=0.05, dec=0.1, sus=1, rel=0.05, curve= (-2), gate=1, high_pass_freq=900, low_pass_freq=100, low_pass_mix=0, high_pass_mix=0, hpf_freq=20, lpf_freq=22000;
		var sig1,sig2, env;
		sig1 = PlayBuf.ar(2, bufnum1, rate, trig, startPos, loop);
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig1 = LPF.ar(sig1 * env * amp.dbamp.lag(0.1), lpf_freq);
		Out.ar([1,3], HPF.ar(sig1, hpf_freq));
	}).add;

	SynthDef(\sub, {
		arg amp=0, out=0, atk=0.05, sus=0.6, dec=20, rel=0.05, curve= (-10), gate=1, time=180;
		var env, sig;
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig = SinOsc.ar(45)!2;
		sig = sig * env * amp.dbamp.lag(0.1);
		Out.ar(out, sig);
	}).add;


	SynthDef(\sub_1, {
		arg amp=0, out=0, atk=0.05, sus=0.6, dec=20, rel=0.05, curve= (-10), gate=1, time=180, amDur=30;
		var env, sig;
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig = SinOsc.ar(45, Rand(0, 2pi)) + SinOsc.ar(Line.kr(51, 47, amDur), Rand(0, 2pi))!2;
		sig = sig * env * amp.dbamp.lag(0.1);
		Out.ar(out, sig);
	}).add;

	//TESTS/////////////////////////////////////////////////////////////////////////////////////////////



	s.sync;



	//TreeAdds

    ServerTree.add(~makeNodes);
	ServerTree.add(~makeMIDI);
	ServerTree.add(~makeEvents);
	s.freeAll; // Frees verver of any nodes. Then inits all instances on ServerTree (above).
	s.sync;
	s.meter;
	"done".postln;

});
)


