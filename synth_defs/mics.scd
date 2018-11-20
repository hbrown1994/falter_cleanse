//Mic
SynthDef(\input_1, {
		arg amp=(-60), gate=1, outputbusCV=~cvBus, outputbusFX=~fxBus,
	inputbus, rel=30, atk=0.005, sus=0, dryamp=0.2, fb=0, modeEnd, modStart, bufnum, hpf_freq=30;
	var in, env, sig, modIn, mult, modFreq=131, sine, temp, modMix, changeTime=0.1;
	in = SoundIn.ar(~micchannel_1);
	//in = PlayBuf.ar(1, bufnum, 1, 1, 0, 1);
	env = EnvGen.kr(Env.adsr(0.1, 0.1, 1, 0.1, 1.0), gate, doneAction:2);
	sig = env * in * amp.dbamp.lag(0.1);
	in = in * env;

	Out.ar(outputbusFX, in);// to processing
	Out.ar(outputbusCV, in);// to cv
		Out.ar([0,1], HPF.ar(sig, hpf_freq.lag(0.1)));// dry
}).add;

//Contact Mic
SynthDef(\input_2, {
	arg amp=(-60), gate=1, outputbusCV=~cvBus, outputbusFX=~fxBus,
	inputbus, rel=30, atk=0.005, sus=0, dryamp=0.2, fb=0, modeEnd, modStart, bufnum;
	var in, env, sig, modIn, mult, modFreq=131, sine, temp, modMix, changeTime=0.1, hpf_freq=30;
	in = SoundIn.ar(~micchannel_2);
	//in = PlayBuf.ar(1, bufnum, 1, 1, 0, 1);
	env = EnvGen.kr(Env.adsr(0.1, 0.1, 1.0, 0.1, 1.0), gate, doneAction:2);
	sig = env * in * amp.dbamp.lag(0.1);
	in = in * env;
	Out.ar(outputbusFX, in);// to processing
	Out.ar(outputbusCV, in);// to cv
	Out.ar([0,1], sig);// dry
}).add;
