	e.add(\19 -> {
		c[1].children[18].value_(0);//Off
	    c[1].children[19].value_(1);//On

	~stochastic_verb = Synth.new(\reverb2, [\atk, 20, \rel, 0.05, \inputbus_Mic, ~fxBus, \amp, ~stochastic_verb_numBox.value, \trig_start, 0.1, \trig_end, 11.0, \trig_dur, 75], target: ~fx).register;

});