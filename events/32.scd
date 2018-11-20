e.add(\32 -> {
	c[1].children[31].value_(0);//Off
	c[1].children[32].value_(1);//On

	~grain_delay.set(\allPassMix, 1, \pitchMapLo, 1.0 , \pitchMapHi, 1.2, \decayLo, 0.2, \decayHi,4, \glitchSpeed, 13, \delayRandLo, 0.1, \delayRandHi, 3, \gate, 1, \inputbus_Mic, ~fxBus_contact_mic, \brickMod, 30, \brickMult, 0, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 0.2, \osc_speed, 3);

});