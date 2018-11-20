SynthDef(\amptracking, {
	arg outputbus=~cvBusSend, inputbus=~cvBus;
	var sig, in;
	in = In.ar(inputbus, 1);
	sig = RMS.kr(in).linlin(0.0, 0.2, 0.0, 1.0);
	Out.kr(outputbus, sig);
}).add;