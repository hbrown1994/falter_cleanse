	e.add(\13 -> {

	c[1].children[12].value_(0);//Off
	c[1].children[13].value_(1);//On


  ~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][13], \loop, 1, \gate, 1, \atk, 60, \rel, 0.05, \curve, \lin, \rate, 1, \amp, ~sine_tones_numBox.value]).register;



	~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][15], \loop, 1, \gate, 1,
				\atk, 60, \rel, 0.05, \curve, \lin, \rate, 0.6, \amp, ~sine_tones_numBox.value]).register;

});