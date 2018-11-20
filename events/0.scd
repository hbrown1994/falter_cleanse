e.add(\0 -> {

	c[1].children[0].value_(1);//On

	Routine({
		~glitch = Synth(\glitchy_freeze, [\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 0, \glitchSpeed, 1, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 20, \brickMult, 0.2, \amp, ~glitch_numBox.value, \rel, 0.05], target: ~fx).register;

		75.wait;

		~drone_1 = Synth(\playbuf_2, [\bufnum1, b[\no_input][12], \loop, 1, \gate, 1, \atk, 140, \rel, 0.05, \curve,0, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

		~drone_2 = Synth(\playbuf_3, [\bufnum1, b[\no_input][15], \loop, 1, \gate, 1,
				\atk, 140, \rel, 0.05, \curve, 0, \rate, 1, \amp, ~sine_tones_numBox.value]).register;

	}).play(AppClock);

});