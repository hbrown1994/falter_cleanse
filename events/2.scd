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