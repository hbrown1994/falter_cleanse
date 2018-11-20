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
