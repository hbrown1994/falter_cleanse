//Create node groups on server.
~patterns = Group.new;
~input = Group.after(~patterns);
~ampTrack = Group.after(~input);
~fx = Group.after(~ampTrack);
~sine = Group.after(~fx);