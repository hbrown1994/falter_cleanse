	e.add(\21 -> {
		c[1].children[20].value_(0);//Off
	    c[1].children[21].value_(1);//On

	~grain_delay = Synth(\glitchy_freeze, [\allPassMix, 1, \pitchMapLo, 0.6 , \pitchMapHi, 1.0, \decayLo, 0.2, \decayHi, 1, \glitchSpeed, 30, \delayRandLo, 0.1, \delayRandHi, 1, \atk, 30, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 50, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 1, \osc_speed, 1], target: ~fx).register;

	});