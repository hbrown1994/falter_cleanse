e.add(\23 -> {
	c[1].children[22].value_(0);//Off
	c[1].children[23].value_(1);//On

	~grain_delay.set(\allPassMix, 1, \pitchMapLo, 0.3 , \pitchMapHi, 2.0, \decayLo, 1, \decayHi, 3, \glitchSpeed, 20, \delayRandLo, 0.01, \delayRandHi, 1, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 100, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 1, \osc_speed, 6);

});