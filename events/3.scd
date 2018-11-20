	e.add(\3 -> {

	"cue 2".postln;
	c[1].children[2].value_(0);//Off
	c[1].children[3].value_(1);//On

	~hi_sine_1.set(\gate, 0);
	~hi_sine_2.set(\gate, 0);
	~sub.set(\gate, 0);


	~grain_delay = Synth(\glitchy_freeze, [\allPassMix, 1, \pitchMapLo, 0.6 , \pitchMapHi, 1.0, \decayLo, 0.2, \decayHi, 1, \glitchSpeed, 30, \delayRandLo, 0.1, \delayRandHi, 1, \atk, 0.1, \gate, 1, \inputbus_Mic, ~fxBus, \brickMod, 50, \brickMult, 1, \amp, ~grain_delay_numBox.value, \rel, 15], target: ~fx).register;


	~metalPicks = Pdef(
		\metalPicks,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pseg(Pseq([0.01, 0.6], 1), 30, \lin),
			\atk, 0.01,
			\rel, Pif(Ptime(inf) < 2.0, 5.0, 3.0),
			\buf, Pxrand(m[\metal_picks][(0..3)], inf),
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

});