e.add(\5 -> {

	c[1].children[4].value_(0);//Off
	c[1].children[5].value_(1);//On

	~contact_mic = Synth(\input_2, [\outputbusFX, ~fxBus_contact_mic, \outputbusCV, ~cvBus, \atk, 0.1, \rel, 0.05], target: ~input).register;


	~glitch_2 = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 1, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 7, \brickMod, 10, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 0.2, \decayHi, 1], target: ~fx).register;

});