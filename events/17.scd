e.add(\17 -> {
	c[1].children[16].value_(0);//Off
	c[1].children[17].value_(1);//On

	Routine({
		~glass = Synth(\playbuf_1, [\bufnum1, b[\glass_8][0], \bufnum2, b[\glass_8][1] ,\bufnum3, b[\glass_8][2] ,\bufnum4, b[\glass_8][3], \lpf_freq, 20000, \hpf, 20, \amp, ~glass_numBox.value, \loop, 1], target: ~patterns).register ;

		30.wait;

		~overPressure = Pdef(
			\overPressure,
			Pbind(
				\instrument, \bpfbuf,
				\dur, 10,
				\atk, 5,
				\rel, 10,
				\buf, Pxrand(m[\over_pressure][(0..0)]++m[\styrofoam][(0..0)], inf),
				\rate, Pbrown(0.1, 0.3, 0.01),
				\spos, 0,
				\amp, Pfunc({~sample_streams_val}),
				\loop, 1,
				\bpfmix, Pseg(Pseq([0.0, 1.0], inf), inf, \lin),
				\freq, Pexprand(40, 100),
				\rq, Pexprand(0.008, 0.005),
				\panX, Pwhite(-1.0, 1.0),
				\panY, Pwhite(-1.0, 1.0),
				\group, ~patterns,
			);
		).play;

	}).play(AppClock);

});