	e.add(\27 -> {
		c[1].children[26].value_(0);//Off
	    c[1].children[27].value_(1);//On

	~ring_mod.set(\gate, 0);
	~drone_1.set(\gate, 0);
	~drone_2.set(\gate, 0);
	~sub.set(\gate, 0);

~hi_sine_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][4], \loop, 1, \gate, 1, \atk, 0.05, \rel, 30, \curve, -8, \rate, 1, \amp, ~hi_sine_numBox.value]).register;

	~hi_sine_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][4], \loop, 1, \gate, 1,
				 \atk, 0.05, \rel, 30, \curve, -8, \rate, 1.121, \amp, ~hi_sine_numBox.value, \startPos, 0 ]).register;


	});