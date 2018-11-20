e.add(\35 -> {
	c[1].children[34].value_(0);//Off
	c[1].children[35].value_(1);//On

	~ring_mod.set(\gate, 0);
	~viola.set(\gate, 0);
	~drone_3.set(\gate, 0, \rel, ~viola_fx_rel);
});