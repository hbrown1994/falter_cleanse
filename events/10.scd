	e.add(\10 -> {

	c[1].children[9].value_(0);//Off
	c[1].children[10].value_(1);//On

	~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pif(Ptime(inf) < 20.0, Pwhite(Pseg(Pseq([0.1, 0.01], inf), Pseq([20.0, 20.0], inf), \linear), Pseg(Pseq([1, 0.02], inf), Pseq([20.0, 20.0], inf), \linear)), Pexprand(0.01, 0.02),inf),

			\atk, Pif(Ptime(inf) < 20.0, Pwhite(Pseg(Pseq([2, 0.01], inf), Pseq([20.0, 20.0], inf), \linear), Pseg(Pseq([4, 0.2], inf), Pseq([20.0, 20.0], inf), \linear)), Pexprand(0.01, 0.2),inf),
			\rel,  Pif(Ptime(inf) < 20.0, Pwhite(Pseg(Pseq([6, 1], inf), Pseq([20.0, 20.0], inf), \linear), Pseg(Pseq([8, 2], inf), Pseq([20.0, 20.0], inf), \linear)), Pexprand(1, 2),inf),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\styrofoam][(0..1)]++m[\metal_picks][(0..3)], inf),
			\rate, Pwhite(0.4, 1),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 0.2,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.8, 0.08),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


		~glitch_2.set(\inputbus_Mic, ~fxBus_contact_mic, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 7, \toggleGate, 0, \atk, 30, \delayRandLo, 0.4, \delayRandHi, 2, \brickMod, 10, \brickMult, 1, \amp, ~glitch_numBox.value, \rel, 0.05, \decayLo, 2, \decayHi, 6);

		~glitch.set(\allPassMix, 0.5, \pitchMapLo, 0.5 , \pitchMapHi, 1.0, \decayLo, 0.01, \decayHi, 1, \glitchSpeed, 20, \delayRandLo, 0.01, \delayRandHi, 0.5);

});