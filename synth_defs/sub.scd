SynthDef(\sub, {
	arg amp=0, out=0, atk=0.05, sus=0.6, dec=20, rel=0.05, curve= (-10), gate=1, time=180;
	var env, sig;
	env = EnvGen.kr(Env.adsr(atk, dec, sus, rel, curve: curve), gate, doneAction: 2);
	sig = SinOsc.ar(45)!2;
	sig = sig * env * amp.dbamp.lag(0.1);
	Out.ar(out, sig);
}).add;