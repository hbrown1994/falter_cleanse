e.add(\12 -> {

	c[1].children[11].value_(0);//Off
	c[1].children[12].value_(1);//On


	Routine({
		~metalPicks = Pdef(
			\metalPicks,
			Pbind(
				\instrument, \bpfbuf,
				\dur, Pif(Ptime(inf) < 110, Pwhite(Pseg(Pseq([10.0, 0.1], 1), 110, \exp), Pseg(Pseq([15.0, 0.3], 1), 110, \exp)),Pwhite(0.06, 0.2)),
				\atk, Pif(Ptime(inf) < 110, Pwhite(Pseg(Pseq([5, 0.02], 1), 110, \exp), Pseg(Pseq([7, 0.08], 1), 110, \exp)),Pwhite(0.02, 0.08)),
				\rel, Pif(Ptime(inf) < 110, Pwhite(Pseg(Pseq([10, 2.0], 1), 110, \exp), Pseg(Pseq([12, 1.0], 1), 110, \exp)), Pwhite(2.0, 1.5)),
				\buf, Pxrand(m[\metal_picks][(0..3)]++m[\square_rod][(0..2)], inf),
				\rate, Pif(Ptime(inf) < 110, Pbrown(Pseg(Pseq([1, 5], 1), 110, \exp), Pseg(Pseq([1, 10], 1), 110, \exp)), Pwhite(-10, -1)),
				\spos, Pif(Ptime(inf) < 110, Pwhite(0, Pseg(Pseq([0, 600], 1), 110, \lin)), Pwhite(0, 600)),
				\amp, Pfunc({~sample_streams_val-1.0}),
				\loop, 1,
				\bpfmix, Pif(Ptime(inf) < 30.0, 1.0, Pseg(Pseq([1.0, 0.0], ), 130, \lin, 1)),
				\freq, Pexprand(200, 800),
				\rq, Pexprand(0.008, 0.005),
				\panX, Pwhite(-1.0, 1.0),
				\panY, Pwhite(-1.0, 1.0),
				\group, ~patterns,
			);
		).play(SystemClock);

		2.wait;

		~ring_mod = Synth(\fbMod, [\inputbus, ~fxBus, \outputbusCV, ~cvBus, \atk, 20, \rel, 0.05, \amp, ~ring_mod_numBox.value, \freq, 1000, \fb_start, 0.01, \fb_end, 6.3, \fb_dur, 50], target: ~fx).register;

	}).play(AppClock);

});