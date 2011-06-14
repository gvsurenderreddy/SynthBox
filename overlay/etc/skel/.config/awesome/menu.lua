-- Aweosme menu file
-- This file is included into the main rc.lua file to build the main menu.

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
ladish_snewapp = "python2 /usr/bin/ladish_control snewapp "


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
	{ "ardour", ladish_snewapp .. "ardour2" },
	{ "ams", ladish_snewapp .. "ams" },
	{ "non midi sequencer", ladish_snewapp .. "non-sequencer" },
	{ "seq24 midi sequencer", ladish_snewapp .. "seq24" },
	{ "bristol mini", ladish_snewapp .. "'startBristol -mini'" },
	{ "yoshimi synth", ladish_snewapp .. "'yoshimi -j -J'" },
	{ "minicomputer synth", ladish_snewapp .. "minicomputer" },
	{ "lv2 synth host", ladish_snewapp .. "zynjacku" },
	{ "lv2 fx host", ladish_snewapp .. "lv2rack" },
	{ "calf synth/fx host", ladish_snewapp .. "calfjackhost" },
	{ "jconvolver", ladish_snewapp .. "Jc_Gui" },
	{ "hydrogen", ladish_snewapp .. "hydrogen" },
	{ "zita autotuner", ladish_snewapp .. "zita-at1" },
	{ "zita reverb", ladish_snewapp .. "zita-rev1" },
	{ "traditional vu meter", ladish_snewapp .. "'jmeters -t vu system:playback_1 system:playback_2'" },
	{ "graphical volume meter", ladish_snewapp .. "jkmeter" },
	{ "audio analyzer", ladish_snewapp .. "'jaaa -J'"},
	{ "linuxsampler", ladish_snewapp .. "qsampler" },
	{ "virtual keyboard", ladish_snewapp .. "jack-keyboard" },
	{ "jamin mastering suite", ladish_snewapp .. "jamin" },
	{ "--" },
	{ "utilities", myutilsmenu},
	{ "system", mysystemmenu},
	}
})
