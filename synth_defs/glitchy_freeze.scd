SynthDef(\glitchy_freeze, {
	arg out=0, buffer=~fftBuff, allPassMix=1, glitchSpeed=20,
	cvbus, atk=10, sus=1, rel=60, gate=1, inputbus_Mic=~outputBusMicFX,
	max=0.4, delay=0.2, decay=2, toggleGate=0, amp=~slider1.value ,
	pitchMapLo = 0.25 ,pitchMapHi = 4.0, delayRandLo = 20,
	delayRandHi = 40, decayLo = 2, decayHi = 30, envCurve =  1, brickMod=10, brickMult = 1, amMix=0, osc_speed =1;

	var in, chain, trig, sig, impulse, cvin, env, temp, freeze, delaySig, gateEnv;
	delaySig = 0;

	in = In.ar(inputbus_Mic, 1);
	cvin = In.kr(cvbus, 1);
	impulse = Dust.kr(glitchSpeed);
	trig = ToggleFF.kr(impulse).linlin(0, 1, toggleGate, 1);
	env = EnvGen.kr(Env.adsr(atk, 1, sus, rel, curve: envCurve), gate, doneAction:2);
	chain = FFT(buffer, in);
	chain = PV_BrickWall(chain, LFNoise1.kr(brickMod, brickMult));
	chain = PV_BinShift(chain, cvin.linlin(0.2, 0.6, pitchMapLo, pitchMapHi));
	chain = PV_MagFreeze(chain, trig);
	freeze = IFFT(chain).dup;
	temp = DelayN.ar(temp, 0,2, 0.1, mul: 1);
	5.do{
		temp = AllpassC.ar(freeze,
			LFNoise2.kr(cvin.exprange(delayRandLo,delayRandHi)).exprange({Rand(0.01,0.2)}, {Rand(0.2,0.5)}),
			LFNoise2.kr(cvin.exprange(delayRandLo,delayRandHi)).exprange({Rand(0.01,0.2)}, {Rand(0.2,0.5)})!2,
			LFNoise2.kr(cvin.exprange(delayRandLo,delayRandHi)).linlin(0, 1.0, decayLo, decayHi));
		delaySig = delaySig + temp;
	};
	sig = XFade2.ar(freeze, delaySig ,allPassMix*2-1);
	sig = sig * env;
	sig  = XFade2.ar(sig, sig * SinOsc.kr(osc_speed).linlin(-1.0, 1.0, 0.0, 1.0), amMix*2-1);
	Out.ar(out, sig*amp.dbamp.lag(0.1));
}).add;