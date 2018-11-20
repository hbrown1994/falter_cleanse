e.add(\stop_reset -> {

~cue=0;

c[0].children[0].value_(0);

		Routine({
			~metalPicks.stop;
		    ~cringle.stop;
		    ~overP.stop;
		    ~overPressure.stop;

			s.sync;

		    s.freeAll;

		}).play(AppClock);

		36.do{
			arg i=(-1);
			{i = i + 1};
			c[1].children[i].value_(0)
		};
	}); 