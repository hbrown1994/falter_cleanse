	e.add(\16 -> {
		c[1].children[15].value_(0);//Off
	    c[1].children[16].value_(1);//On

		Routine({

~glitch.set(\inputbus_Mic, ~fxBus, \inputbus_Samples, ~delayIn, \pitchMapLo, 0.8 , \pitchMapHi, 1.0, \cvbus, ~outputamp, \gate, 1, \allPassMix, 1, \glitchSpeed, 2, \toggleGate, 0, \atk, 30, \delayRandLo, 1, \delayRandHi, 2, \brickMod, 400, \brickMult, 0.8, \amp, ~glitch_numBox.value, \rel, 0.05);

		~ring_mod.set(\gate, 0);
	    ~glitch.set(\gate, 0);

		~drone_1.set(\gate, 0);
		~drone_2.set(\gate, 0);


	~sub = Synth(\sub, [\gate, 1, \amp, ~sub_numBox.value, \atk, 0.05, \rel, 15, \curve, -4, \amp, ~sub_numBox.value, \out,~sub_out]).register;


		~metalPicks.stop;

		~overP = Pdef(
				\OverP,
				Pbind(
					\instrument, \bpfbuf,
					\dur, Pwhite(0.001, 0.03),
					\atk, Pexprand(0.02,0.08),
					\rel, Pwhite(0.003, 0.01),
					\buf, Pxrand(m[\over_pressure][(0..2)], inf),
					\rate, 1,
					\spos, Pwhite(0, 1000),
					\amp, Pfunc({~sample_streams_val-3.0}),
					\pan, {Pexprand(-1.0, 1.0)},
					\bpfmix, 0,
					\out, 0,
					\panX, Pwhite(-1.0, 1.0),
					\panY, Pwhite(-1.0, 1.0),
					\group, ~patterns,
				);
			).play(SystemClock);

			~metalPicks_1 = Pdef(
		\metalPicks,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pseg(Pseq([0.01, 0.6], 1), 30, \lin),
			\atk, 0.01,
			\rel, Pif(Ptime(inf) < 2.0, 5.0, 3.0),
			\buf, Pxrand(m[\metal_picks][(0..3)]++m[\styrofoam][(0..1)], inf),
			\rate, Pif(Ptime(inf) < 2.0, Pwhite(2.0, 4.0, inf), Pseg(Pseq([2.0, -0.5], 1), 40, \lin)),
			\spos, 0,
			\amp, Pfunc({~sample_streams_val-1.0}),
			\loop, 1,
		    \bpfmix, Pseg(Pseq([0.0, 1.0], 1), 60, \lin),
		    \freq, Pexprand(60, 10000),
		    \rq, Pexprand(0.008, 0.005),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);

		5.wait;

		~sub.set(\gate, 0);

		15.wait;

	   ~overP.stop;

		}).play(AppClock);

	});