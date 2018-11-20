	e.add(\20 -> {
		c[1].children[19].value_(0);//Off
	    c[1].children[20].value_(1);//On

		~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][12], \loop, 1, \gate, 1, \atk, 30, \rel, 0.05, \curve, \exp, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][15], \loop, 1, \gate, 1,
				\atk, 30, \rel, 0.05, \curve, \exp, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	});