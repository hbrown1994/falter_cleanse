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