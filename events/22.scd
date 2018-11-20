e.add(\22 -> {
	c[1].children[21].value_(0);//Off
	c[1].children[22].value_(1);//On

	~grain_delay.set(\allPassMix, 1, \pitchMapLo, 0.6 , \pitchMapHi, 1.0, \decayLo, 1, \decayHi, 2, \glitchSpeed, 20, \delayRandLo, 0.1, \delayRandHi, 1, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 100, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 1, \osc_speed, 3)
});