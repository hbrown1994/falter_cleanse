SynthDef(\bpfbuf, {
		arg atk=0, sus=0, rel=3, c1=1, c2=(-1),
		buf=0, rate=1, spos=0, freq=440, rq=1, bpfmix=0,
		panX=0, panY=0, amp=0.0, out=~inputbus1, loop=1,
	    combmix=0, delayTime=0.2, decayTime=1.0;
		var sig, env;
		env = EnvGen.kr(Env([0.0,1.0,1.0,0.0],[atk,sus,rel],[c1,0,c2]),doneAction:2);
		sig = PlayBuf.ar(1, buf, rate*BufRateScale.ir(buf), startPos:spos, loop: loop);
	    sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), (bpfmix*2-1));
	    sig = sig * env;
		sig = Pan4.ar(sig, panX, panY);
		Out.ar(out, sig * amp.dbamp.lag(0.1));
}).add;