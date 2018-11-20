	e.add(\15 -> {

		c[1].children[14].value_(0);//Off
	    c[1].children[15].value_(1);//On


		~glitch.set(\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 2, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 400, \brickMult, 0.8, \amp, ~glitch_numBox.value, \rel, 0.05);

	});