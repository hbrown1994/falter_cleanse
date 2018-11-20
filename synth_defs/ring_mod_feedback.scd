SynthDef(\fbMod, {
	arg amp=0.5, gate=1, outputbusCV=~cvBus, outputbusFX=~fxBus,
	inputbus, rel=30, atk=0.005, sus=0.5, dryamp=0.2, fb=0, modeEnd, modStart, out=0, changeTime=0.1, startAmount = 0.0, endAmount = 1.0, decay=0.3, fb_amount=0.0, freq=300, fb_start, fb_end, fb_dur;
	var in, env, sig, modIn, mult, modFreq=131, sine, temp, modMix;
	sig = In.ar(inputbus)!2;
	env = EnvGen.kr(Env.adsr(atk, decay, sus, rel, sustainLevel: 1.0), gate, doneAction:2);
	sig = sig * SinOscFB.ar(freq, XLine.kr(fb_start, fb_end, fb_dur), 1.0);
	sig = env * sig * amp.dbamp.lag(0.1);
	Out.ar(outputbusFX, sig);
	Out.ar(out, sig);
}).add;