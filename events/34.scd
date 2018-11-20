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