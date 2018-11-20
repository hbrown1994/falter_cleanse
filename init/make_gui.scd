//GUI for real-time control over the SuperCollider code.

//Makes Window to house GUI objects
Window.closeAll;
w = Window("Falter/Cleanse", Rect(750,50,1200,600))
.front
.alwaysOnTop_(true);

/*______________________________________________ 1. Static Text Labels for all 8 Composite Views  ______________________________________________*/
// Composite View 0//////////////
StaticText(w, Rect(0,0,580,40))
.string_("Falter/Cleanse")
.align_(\center)
.front
.stringColor_(Color(1, 1, 1))
.font_(Font(size: 30));

StaticText(w, Rect(0,35,580,40))
.string_("By Hunter Brown")
.align_(\center)
.front
.stringColor_(Color(1, 1, 1))
.font_(Font(size: 30));

// Composite View 1//////////////
StaticText(w, Rect(602,5,580,30))
.string_("Rehearsal Cues")
.align_(\center)
.front
.stringColor_(Color(1, 1, 1))
.font_(Font(size: 30));

// Composite View 2//////////////
StaticText(w, Rect(0,200,70,30))
.string_("Glass")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(120,200,70,30))
.string_("Hi Tones")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(240,200,70,30))
	.string_("Sub")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(351,200,90,30))
.string_("HPF")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(400,370,70,30))
.string_("hz")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(280,370,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(160,370,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(40,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(400,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(280,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(160,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

// Composite View 3//////////////
StaticText(w, Rect(640,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(520,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(760,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(880,570,70,30))
.string_("dbs")
.align_(\center)
.front
.font_(Font(size: 15));

// Composite View 4-7//////////////
StaticText(w, Rect(0,400,75,30))
.string_("Dry Viola")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(110,400,100,30))
.string_("Contact Mic")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(215,400,120,30))
.string_("Glitch")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(348,400,100,30))
.string_("Grain Delay")
.align_(\center)
.front
.font_(Font(size: 15));


StaticText(w, Rect(460,400,110,30))
	.string_("Ring Mod")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(580,400,110,30))
.string_("Stoc Verb")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(700,400,110,30))
.string_("Algo Samples")
.align_(\center)
.front
.font_(Font(size: 15));

StaticText(w, Rect(819,400,110,30))
.string_("Drones")
.align_(\center)
.front
.font_(Font(size: 15));


/*______________________________________________ 2. Assign GUI objects to composite views  ______________________________________________*/

// Create Composite Views ------------------------------------------

w.view.decorator_(FlowLayout(w.bounds, 0@0, 0@0));

c = Array.fill( 6, {
	arg view;
	view = CompositeView(w, 600@200)
	.background_();

	view.decorator_(FlowLayout(view.bounds, 10@25, 70@0));
});

// Composite View 0: Init, Stop Reset, and Cue ------------------------------------------
c[0].background_(Color(0, 0, 0));
c[0].decorator_(FlowLayout(c[0].bounds, 90@40, 15@15)); // Array 0
c[0].decorator.nextLine;
c[0].decorator.nextLine;
c[0].decorator.nextLine;
Array.fill(1, {Button(c[0], 200@50).font_(Font(size: 30)).states_([["Initialization", Color.black, Color.gray(0.8)],["Initialized", Color.white, Color(0,0,0)]])});
Array.fill(1, {Button(c[0], 200@50).font_(Font(size: 30)).states_([["Stop & Reset", Color.black, Color.gray(0.8)]])});

c[0].decorator.nextLine;
c[0].decorator_(FlowLayout(c[0].bounds, 190@140, 15@15)); // Array 0
Array.fill(1, {Button(c[0], 200@50).font_(Font(size: 30)).states_([["Cue", Color.black, Color.gray(0.8)]])});

// Composite View 1: Cues ------------------------------------------
c[1].background_(Color(0, 0, 0));
c[1].decorator_(FlowLayout(c[0].bounds, 15@15, 10@15)); // Array 1
c[1].decorator.nextLine;
c[1].decorator.nextLine;
Array.fill(36, {
		arg i=(-1);
		{i = i + 1};
		Button(c[1], 35@35).states_([[i.asString, Color.black, Color.gray(0.8)],[i.asString, Color.white, Color(0,0,0)]])});


// Composite View 2: Audio Control ------------------------------------------
c[2].background_(Color(1, 1, 1));

Array.fill(4, {Slider(c[2], 50@150)});
c[2].decorator.nextLine;
Array.fill(4, {NumberBox(c[2], 50@20)});

// Composite View 3: Audio Control ------------------------------------------
c[3].background_(Color(1, 1, 1));

// Composite View 4: Audio Control ------------------------------------------
c[4].background_(Color(1, 1, 1));

Array.fill(5, {Slider(c[4], 50@150)});
c[4].decorator.nextLine;
Array.fill(5, {NumberBox(c[4], 50@20)});

// Composite View 5: Audio Control ------------------------------------------

c[5].background_(Color(1, 1, 1));

Array.fill(3, {Slider(c[5], 50@150)});
c[5].decorator.nextLine;
Array.fill(3, {NumberBox(c[5], 50@20)});

/*______________________________________________ 3. INIT GUI Objects  ______________________________________________*/
c[2].children[0].valueAction_(-60.0);
c[2].children[1].valueAction_(-60.0);
c[2].children[2].valueAction_(-60.0);
c[2].children[3].valueAction_(-60.0);
c[2].children[4].valueAction_(-60.0);
c[2].children[5].valueAction_(-60.0);
c[2].children[6].valueAction_(-60.0);
c[2].children[7].valueAction_(-60.0);


c[4].children[0].valueAction_(-60.0);
c[4].children[1].valueAction_(-60.0);
c[4].children[2].valueAction_(-60.0);
c[4].children[3].valueAction_(-60.0);
c[4].children[4].valueAction_(-60.0);
c[4].children[5].valueAction_(-60.0);
c[4].children[6].valueAction_(-60.0);
c[4].children[7].valueAction_(-60.0);
c[4].children[8].valueAction_(-60.0);
c[4].children[9].valueAction_(-60.0);

c[5].children[0].valueAction_(-60.0);
c[5].children[1].valueAction_(-60.0);
c[5].children[2].valueAction_(-60.0);
c[5].children[3].valueAction_(-60.0);
c[5].children[4].valueAction_(-60.0);
c[5].children[5].valueAction_(-60.0);


/*______________________________________________ 4. GUI Object Functionality  ______________________________________________*/
~init_button = c[0].children[0]
.action_({
	arg obj;
	if(obj.value == 1, {e[\init].value;"init".postln},{nil});
});

~stop_button = c[0].children[1]
	.mouseDownAction_({e[\stop_reset].value})

	.mouseUpAction_({~init_button.valueAction = 0});

~next_cue_button = c[0].children[2]
.mouseDownAction_({e[~cue.asSymbol].value;
})
.mouseUpAction_({
		~cue = ~cue + 1;
});

~rehearsal_cue_button_0 = c[1].children[0]
.mouseDownAction_({
		~cue=0;
});

~rehearsal_cue_button_1 = c[1].children[1]
.mouseDownAction_({
		~cue=1;
});

~rehearsal_cue_button_2 = c[1].children[2]
.mouseDownAction_({
		~cue=2;
});

~rehearsal_cue_button_3 = c[1].children[3]
.mouseDownAction_({
		~cue=3;
});

~rehearsal_cue_button_4 = c[1].children[4]
.mouseDownAction_({
		~cue=4;
});

~rehearsal_cue_button_5 = c[1].children[5]
.mouseDownAction_({
		~cue=5;
});

~rehearsal_cue_button_6 = c[1].children[6]
.mouseDownAction_({
		~cue=6;
});

~rehearsal_cue_button_7 = c[1].children[7]
.mouseDownAction_({
		~cue=7;
});


~rehearsal_cue_button_8 = c[1].children[8]
.mouseDownAction_({
		~cue=8;
});

~rehearsal_cue_button_9 = c[1].children[9]
.mouseDownAction_({
		~cue=9;
});

~rehearsal_cue_button_10 = c[1].children[10]
.mouseDownAction_({
		~cue=10;
});

~rehearsal_cue_button_11 = c[1].children[11]
.mouseDownAction_({
		~cue=11;
});

~rehearsal_cue_button_12 = c[1].children[12]
.mouseDownAction_({
		~cue=12;
});

~rehearsal_cue_button_13 = c[1].children[13]
.mouseDownAction_({
		~cue=13;
});

~rehearsal_cue_button_14 = c[1].children[14]
.mouseDownAction_({
		~cue=14;
});

~rehearsal_cue_button_15 = c[1].children[15]
.mouseDownAction_({
		~cue=15;
});

~rehearsal_cue_button_16 = c[1].children[16]
.mouseDownAction_({
		~cue=16;
});

~rehearsal_cue_button_17 = c[1].children[17]
.mouseDownAction_({
		~cue=17;
});

~rehearsal_cue_button_18 = c[1].children[18]
.mouseDownAction_({
		~cue=18;
});

~rehearsal_cue_button_19 = c[1].children[19]
.mouseDownAction_({
		~cue=19;
});


~rehearsal_cue_button_20 = c[1].children[20]
.mouseDownAction_({
		~cue=20;
});

~rehearsal_cue_button_21 = c[1].children[21]
.mouseDownAction_({
		~cue=21;
});

~rehearsal_cue_button_22 = c[1].children[22]
.mouseDownAction_({
		~cue=22;
});

~rehearsal_cue_button_23 = c[1].children[23]
.mouseDownAction_({
		~cue=23;
});

~rehearsal_cue_button_24 = c[1].children[24]
.mouseDownAction_({
		~cue=24;
});

~rehearsal_cue_button_25 = c[1].children[25]
.mouseDownAction_({
		~cue=25;
});

~rehearsal_cue_button_26 = c[1].children[26]
.mouseDownAction_({
		~cue=26;
});

~rehearsal_cue_button_27 = c[1].children[27]
.mouseDownAction_({
		~cue=27;
});

~rehearsal_cue_button_28 = c[1].children[28]
.mouseDownAction_({
		~cue=28;
});

~rehearsal_cue_button_29 = c[1].children[29]
.mouseDownAction_({
		~cue=29;
});

~rehearsal_cue_button_30 = c[1].children[30]
.mouseDownAction_({
		~cue=30;
});

~rehearsal_cue_button_31 = c[1].children[31]
.mouseDownAction_({
		~cue=31;
});

~rehearsal_cue_button_32 = c[1].children[32]
.mouseDownAction_({
		~cue=32;
});

~rehearsal_cue_button_33 = c[1].children[33]
.mouseDownAction_({
		~cue=33;
});

~rehearsal_cue_button_34 = c[1].children[34]
.mouseDownAction_({
		~cue=34;
});


~rehearsal_cue_button_35 = c[1].children[35]
.mouseDownAction_({
		~cue=35;
});


~glass_slider = c[2].children[0]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60, 1);
		if(~glass.isPlaying,
	{~glass.set(\amp, amp)}
);
~glass_numBox.value_(obj.value.linlin(0.0,1.0,-60, 1));
});
~glass_numBox = c[2].children[4]
.decimals_(1)
.clipLo_(-60)
.clipHi_(0.0)
.action_({
	arg obj;
~glass_slider.valueAction_(obj.value.linlin(-60, 1, 0.0,1.0))
});


~hi_sine_slider = c[2].children[1]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~hi_sine_1.isPlaying,
	{~hi_sine_1.set(\amp, amp)}
);

	if(~hi_sine_2.isPlaying,
	{~hi_sine_2.set(\amp, amp)}
);

	~hi_sine_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});
~hi_sine_numBox = c[2].children[5]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~hi_sine_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~sub_slider = c[2].children[2]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~sub.isPlaying,
			{~sub.set(\amp, amp)});

    if(~sub_1.isPlaying,
			{~sub_1.set(\amp, amp)});



	~sub_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});
~sub_numBox = c[2].children[6]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~sub_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~delay_feedback_slider = c[2].children[3]
.action_({
	arg obj;
	var hpf_freq;
	hpf_freq = obj.value.linlin(0.0,1.0,30.0,100.0);
		if(~viola.isPlaying,
	{~viola.set(\hpf_freq, hpf_freq)}
);

	if(~contact_mic.isPlaying,
	{~contact_mic.set(\hpf_freq, hpf_freq)}
);
~delay_feedback_numBox.value_(obj.value.linlin(0.0,1.0,30.0,100.0));
});
~delay_feedback_numBox = c[2].children[7]
.decimals_(1)
.clipLo_(30.0)
.clipHi_(100.0)
.action_({
	arg obj;
~delay_feedback_slider.valueAction_(obj.value.linlin(30.0,100.0, 0.0,1.0))
});


~viola_slider = c[4].children[0].action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0, -60.0,0.0);
	if(~viola.isPlaying,
	{~viola.set(\amp, amp)}
);
	~viola_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});

~viola_numBox = c[4].children[5]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~viola_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~contact_mic_slider = c[4].children[1]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~contact_mic.isPlaying,
	{~contact_mic.set(\amp, amp)}
);



~contact_mic_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});
~contact_mic_numBox = c[4].children[6]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
~contact_mic_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~glitch_slider = c[4].children[2].action_({
	arg obj;
		var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0, 5.0);
	if(~glitch.isPlaying,
	{~glitch.set(\amp, amp)}

);

	if(~glitch_2.isPlaying,
	{~glitch_2.set(\amp, amp)}

);
	~glitch_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,5.0));
});

~glitch_numBox = c[4].children[7]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(5.0)
.action_({
	arg obj;
	~glitch_slider.valueAction_(obj.value.linlin(-60.0,5.0, 0.0,1.0))
});


~grain_delay_slider = c[4].children[3]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~grain_delay.isPlaying,
	{~grain_delay.set(\amp, amp)}
);
	~grain_delay_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});
~grain_delay_numBox = c[4].children[8]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~grain_delay_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~ring_mod_slider = c[4].children[4]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~ring_mod.isPlaying,
	{~ring_mod.set(\amp, amp)}
);
	~ring_mod_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});
~ring_mod_numBox = c[4].children[9]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~ring_mod_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});


~stochastic_verb_slider = c[5].children[0]
.action_({
	arg obj;
	var amp;
	~stochastic_verb_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));

		amp = obj.value.linlin(0.0,1.0,-60.0,-0.0);

		if(~stochastic_verb.isPlaying,
	{~stochastic_verb.set(\amp, amp)}
);
});
~stochastic_verb_numBox = c[5].children[3]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~stochastic_verb_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});

~sample_streams_slider = c[5].children[1]
.action_({
	arg obj;
	var amp;
	~sample_streams_val = obj.value.linlin(0.0,1.0,-60.0,0.0);

	~sample_streams_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});
~sample_streams_numBox = c[5].children[4]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~sample_streams_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});


~sine_tones_slider = c[5].children[2]
.action_({
	arg obj;
	var amp;
	amp = obj.value.linlin(0.0,1.0,-60.0,0.0);
	if(~drone_1.isPlaying,
	{~drone_1.set(\amp, amp)}
);

	if(~drone_2.isPlaying,
	{~drone_2.set(\amp, amp)}
);


	if(~drone_3.isPlaying,
	{~drone_3.set(\amp, amp)}
);

	~sine_tones_numBox.value_(obj.value.linlin(0.0,1.0,-60.0,0.0));
});
~sine_tones_numBox = c[5].children[5]
.decimals_(1)
.clipLo_(-60.0)
.clipHi_(0.0)
.action_({
	arg obj;
	~sine_tones_slider.valueAction_(obj.value.linlin(-60.0,0.0, 0.0,1.0))
});