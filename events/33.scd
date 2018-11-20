e.add(\33 -> {
	c[1].children[32].value_(0);//Off
	c[1].children[33].value_(1);//On

	~grain_delay.set(\allPassMix, 1, \pitchMapLo, 1.0 , \pitchMapHi, 1.2, \decayLo, 0.2, \decayHi,4, \glitchSpeed, 6, \delayRandLo, 0.1, \delayRandHi, 3, \gate, 1, \inputbus_Mic, ~fxBus_contact_mic, \brickMod, 30, \brickMult, 0, \amp, ~grain_delay_numBox.value, \rel, 15, \amMix, 0.6, \osc_speed, 3);

	~ring_mod = Synth(\fbMod, [\inputbus, ~fxBus, \outputbusCV, ~cvBus, \atk, 10, \rel, 0.05, \fb_Amount, 0, \amp, ~ring_mod_numBox.value, \freq, 4000, \fb_start, 0.01, \fb_end, 6.3, \fb_dur, 45], target: ~fx).register;

	~stochastic_verb.set(\gate, 0);
});
