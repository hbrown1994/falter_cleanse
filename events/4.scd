e.add(\4 -> {

	"cue 3".postln;
	c[1].children[3].value_(0);//Off
	c[1].children[4].value_(1);//On

	~grain_delay.set(\gate, 0);


	~cringle = Pdef(
		\cringle,
		Pbind(
			\instrument, \bpfbuf,
			\dur, Pwhite(2, 4),
			\atk, Pwhite(2, 4),
			\rel, Pwhite(6, 8),
			\buf, Pxrand(m[\cringle_1][(0..3)]++m[\cringle_2][(0..3)]++m[\cringle_3][(0..3)]++m[\cringle_4][(0..3)]++m[\cringle_5][(0..3)]++m[\cringle_6][(0..3)]++m[\cringle_7][(0..3)]++m[\cringle_8][(0..3)], inf),
			\rate, Pwhite(0.01, 0.8),
			\spos, Pwhite(0.0, 10000),
			\amp, Pfunc({~sample_streams_val}),
			\loop, 1,
		    \bpfmix, 1,
			\freq, Pexprand(300, 2000),
		    \rq, Pexprand(0.008, 0.0002),
			\panX, Pwhite(-1.0, 1.0),
		    \panY, Pwhite(-1.0, 1.0),
			\group, ~patterns,
		);
	).play(SystemClock);


});