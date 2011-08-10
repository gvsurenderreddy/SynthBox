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
	{ "klaudia", "klaudia" },
	{ "claudia", "claudia" },
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
	{ "ardour", ladish_snewapp .. "ardour2 'ardour'" },
	{ "ams", ladish_snewapp .. "ams 'ams'" },
	{ "non-sequencer", ladish_snewapp .. "non-sequencer 'non-sequencer'" },
	{ "seq24 sequencer", ladish_snewapp .. "seq24 'seq24 sequencer'" },
	{ "bristol mini", ladish_snewapp .. "'startBristol -mini' 'bristol mini'" },
	{ "yoshimi synth", ladish_snewapp .. "'yoshimi -j -J' 'yoshimi synth'" },
	{ "minicomputer synth", ladish_snewapp .. "minicomputer 'minicomputer synth'" },
	{ "lv2 synth host", ladish_snewapp .. "zynjacku 'lv2 synth host'" },
	{ "lv2 fx host", ladish_snewapp .. "lv2rack 'lv2 fx host'" },
	{ "calf synth/fx host", ladish_snewapp .. "calfjackhost 'calf host'" },
	{ "jconvolver", ladish_snewapp .. "Jc_Gui 'jconvolver'" },
	{ "hydrogen", ladish_snewapp .. "hydrogen 'hydroge'" },
	{ "zita autotuner", ladish_snewapp .. "zita-at1 'zita autotuner'" },
	{ "zita reverb", ladish_snewapp .. "zita-rev1 'zita reverb'" },
	{ "traditional vu meter", ladish_snewapp .. "'jmeters -t vu system:capture_1 system:capture_2' 'vu meter'" },
	{ "graphical volume meter", ladish_snewapp .. "jkmeter 'volume meter'" },
	{ "audio analyzer", ladish_snewapp .. "'jaaa -J' 'audio analyzer'"},
	{ "linuxsampler", ladish_snewapp .. "qsampler 'linuxsampler'" },
	{ "virtual keyboard", ladish_snewapp .. "jack-keyboard 'virtual keyboard'" },
	{ "jamin mastering suite", ladish_snewapp .. "jamin 'jamin'" },
	{ "--" },
	{ "utilities", myutilsmenu},
	{ "system", mysystemmenu},
	}
})
