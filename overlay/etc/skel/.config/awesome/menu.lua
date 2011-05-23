-- Aweosme menu file
-- This file is included into the main rc.lua file to build the main menu.

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor


-- Create a laucher widget and a main menu

myutilsmenu = {
	{ "terminal", terminal},
	{ "file manager", "thunar"},
	{ "gladish", "gladish" },
	{ "alsamixer", terminal .. " -e alsamixer" },
}

mysystemmenu = {
	{ "gtk2 theme", "gtk-theme-switch2" },
	{ "htop", terminal .. " -e htop" },
	{ "--" },
	{ "restart wm", awesome.restart },
	{ "quit to term", awesome.quit },
	{ "shutdown", terminal .. " -e sudo poweroff" },
	{ "reboot", terminal .. " -e sudo reboot" },
}

mymainmenu = awful.menu.new(
	{ items = { 
	{ "-+=Menu=+-", ""},
	{ "ardour", "ardour2" },
	{ "ams", "ams" },
	{ "non midi sequencer", "non-sequencer" },
	{ "seq24 midi sequencer", "seq24" },
	{ "bristol mini", "startBristol -mini" },
	{ "yoshimi synth", "yoshimi -j -J" },
	{ "minicomputer synth", "minicomputer" },
	{ "lv2 synth host", "zynjacku" },
	{ "lv2 fx host", "lv2rack" },
	{ "calf synth/fx host", "calfjackhost" },
	{ "jconvolver", "Jc_Gui" },
	{ "hydrogen", "hydrogen" },
	{ "zita autotuner", "zita-at1" },
	{ "zita reverb", "zita-rev1" },
	{ "traditional vu meter", "jmeters -t vu system:playback_1 system:playback_2" },
	{ "graphical volume meter", "jkmeter" },
	{ "audio analyzer", "jaaa -J"},
	--{ "linuxsampler", "qsampler" },
	{ "virtual keyboard", "jack-keyboard" },
	{ "jamin mastering suite", "jamin" },
	{ "--" },
	{ "utilities", myutilsmenu},
	{ "system", mysystemmenu},
	}
})
