	e.add(\18 -> {
		c[1].children[17].value_(0);//Off
	    c[1].children[18].value_(1);//On

		~contact_mic = Synth(\input_2, [\outputbusFX, ~fxBus_contact_mic, \outputbusCV, ~cvBus, \atk, 10, \rel, 0.1, \bufnum, b[\square_rod][0]], target: ~input).register;

});