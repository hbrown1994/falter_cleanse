e.add(\init -> {
	~viola = Synth(\input_1, [\outputbusFX, ~fxBus, \outputbusCV, ~cvBus, \atk, 0.1, \rel, 0.1], target: ~input).register;
    Synth(\amptracking, [\inputbus, ~cvBus, \outputbus, ~cvBusSend], target: ~ampTrack);
});