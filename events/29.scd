e.add(\29 -> {
	c[1].children[28].value_(0);//Off
	c[1].children[29].value_(1);//On

	Routine({
		~glitch = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 1, \toggleGate, 0, \atk, 15, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 20, \brickMult, 0.2, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;

		~glitch_2 = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus_contact_mic, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 1, \toggleGate, 0, \atk, 15, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 20, \brickMult, 0.2, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;

		~contact_mic = Synth(\input_2, [\outputbusFX, ~fxBus_contact_mic, \outputbusCV, ~cvBus, \atk, 10, \rel, 0.1, \bufnum, b[\square_rod][1]], target: ~input).register;

	}).play(AppClock);

});