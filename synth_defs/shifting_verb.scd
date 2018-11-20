SynthDef(\reverb2, {
	arg inputbus_Mic=~fxBus, inputbus_Samples = ~reverbIn, predelay=0.1, revtime=1.8,
	lpf=4500, mix=1, amp=1, out=0, sendsOut=~reverbOut, gate=1, atk=0, sus=1, rel=6, c1=1, c2=(-1), changeTime = 50, startAmount=30, endAmount=0.5, trig_start, trig_end, trig_dur;
	var dry, wet, temp, sig, env, temp1, trig1, trig2;
	dry = In.ar(inputbus_Mic,1);
	temp1 = In.ar(~verbSend,1);
	temp = dry + temp1;
	env = EnvGen.kr(Env.adsr(atk, 0.3, sus, rel, 0.3, \lin), gate, doneAction:2);
	wet = 0;
	trig1 = Dust.kr(XLine.kr(trig_start, trig_end, trig_dur));
	trig2 = Dust.kr(XLine.kr(trig_start, trig_end, trig_dur));
	temp = DelayN.ar(temp, 0,2, predelay, mul: 3);
	20.do{
		temp = AllpassL.ar(temp, {Rand(0.001,0.02)}, {TRand.kr(0.001,0.02, trig1)}, {TRand.kr(0.01, 0.3, trig2)});
		temp = LPF.ar(temp, {TRand.kr(1000, 6000, trig1)});
		Out.ar({IRand(0, ~channelAmount)}, Limiter.ar(HPF.ar(temp*amp.dbamp.lag(0.1)*env, 100), 0.9));
	};
}).add;