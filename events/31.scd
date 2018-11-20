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
