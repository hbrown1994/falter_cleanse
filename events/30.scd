e.add(\30 -> {
	c[1].children[29].value_(0);//Off
	c[1].children[30].value_(1);//On

	Routine({

		~cringle_1 = Pdef(
			\cringle,
			Pbind(
				\instrument, \bpfbuf,
				\dur, Pwhite(0.003, 0.005),
				\atk, 0.005,
				\rel, Pwhite(0.2, 1),
				\buf, Pxrand(m[\glass_7][(0..3)], inf),
				\rate, Pxrand([Pwhite(0.5, 20), Pwhite(-0.5, -20)], inf),
				\spos, Pwhite(0.0, 1230000.0),
				\amp, Pfunc({~sample_streams_val+6}),
				\loop, 1,
				\bpfmix,0,
				\freq, Pexprand(300, 2000),
				\rq, Pexprand(0.008, 0.0002),
				\panX, Pwhite(-1.0, 1.0),
				\panY, Pwhite(-1.0, 1.0),
				\group, ~patterns,
			);
		).play(SystemClock);

		~sub = Synth(\sub, [\gate, 1, \amp, ~sub_numBox.value, \atk, 0.1, \rel, 30, \curve, -8, \amp, ~sub_numBox.value, \out, ~sub_out]).register;


		~glitch_2.set(\gate, 0);
		~glitch.set(\gate, 0);

		15.wait;

		~sub.set(\gate, 0);

		~cringle_1 = Pdef(
			\cringle,
			Pbind(
				\instrument, \bpfbuf,
				\dur, Pif(Ptime(inf) < 15.0, Pwhite(Pseg(Pseq([0.003, 0.2], inf), Pseq([15.0, 15.0], inf), \linear), Pseg(Pseq([0.005, 0.5], inf), Pseq([15.0, 15.0], inf), \linear)), Pexprand(3, 5),inf),
				\atk, 0.005,
				\rel, Pif(Ptime(inf) < 15.0, Pwhite(Pseg(Pseq([1, 3], inf), Pseq([15.0, 15.0], inf), \linear), Pseg(Pseq([3, 5], inf), Pseq([15.0, 15.0], inf), \linear)), Pexprand(2, 5),inf),
				\buf, Pxrand(m[\glass_7][(0..3)]++m[\cringle_1][(0..3)], inf),
				\rate, Pif(Ptime(inf) < 15.0, Pwhite(Pseg(Pseq([-0.5, -0.2], inf), Pseq([15.0, 15.0], inf), \linear), Pseg(Pseq([-20, -0.7], inf), Pseq([15.0, 15.0], inf), \linear)), Pexprand(0.2, 0.7),inf),
				\spos, Pwhite(0.0, 10000.0),
				\amp, Pfunc({~sample_streams_val}),
				\loop, 1,
				\bpfmix,0,
				\freq, Pexprand(300, 2000),
				\rq, Pexprand(0.008, 0.0002),
				\panX, Pwhite(-1.0, 1.0),
				\panY, Pwhite(-1.0, 1.0),
				\group, ~patterns,
			);
		).play(SystemClock);

		20.wait;

		~cringle_1.stop;

	}).play(AppClock);

});