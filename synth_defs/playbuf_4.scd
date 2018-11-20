    SynthDef(\playbuf_4, {
		arg bufnum1, bufnum2,  rate=1, trig, startPos=0, loop=1, amp=(-20), atk=0.05, dec=0.1, sus=1, rel=0.05, curve= (-2), gate=1, high_pass_freq=900, low_pass_freq=100, low_pass_mix=0, high_pass_mix=0, hpf_freq=20, lpf_freq=22000;
		var sig1,sig2, env;
		sig1 = PlayBuf.ar(2, bufnum1, rate, trig, startPos, loop);
		env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
		sig1 = LPF.ar(sig1 * env * amp.dbamp.lag(0.1), lpf_freq);
		Out.ar([0,2], HPF.ar(sig1, hpf_freq));
	}).add;