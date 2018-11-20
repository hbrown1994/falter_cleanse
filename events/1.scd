e.add(\1 -> {
	c[1].children[0].value_(0);//Off
	c[1].children[1].value_(1);//On

	~glitch.set(\allPassMix, 0.5, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \decayLo, 0.01, \decayHi, 1, \glitchSpeed, 20, \delayRandLo, 1, \delayRandHi, 2);

});