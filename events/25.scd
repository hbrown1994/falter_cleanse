e.add(\25 -> {
	c[1].children[24].value_(0);//Off
	c[1].children[25].value_(1);//On


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