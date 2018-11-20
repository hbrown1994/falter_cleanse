	e.add(\6 -> {

	c[1].children[5].value_(0);//Off
	c[1].children[6].value_(1);//On

~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(1, 3),
			\atk, Pwhite(2, 4),
			\rel, Pwhite(6, 8),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\cringle_2][(0..3)]++m[\cringle_3][(0..3)]++m[\cringle_4][(0..3)]++m[\cringle_5][(0..3)]++m[\cringle_6][(0..3)]++m[\cringle_7][(0..3)]++m[\cringle_8][(0..3)], inf),
			\rate, Pwhite(0.1, 1),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 0.9,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.008, 0.0002),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


		~glitch_2.set(\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 2, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 7, \brickMod, 12, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 0.7, \decayHi, 2);

});