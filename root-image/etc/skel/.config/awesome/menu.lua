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
	{ "klaudia app library", "klaudia" },
	{ "claudia control app", "claudia" },
	{ "gladish control app", "gladish" },
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
	--{ "ardour", ladish_snewapp .. "ardour2 'ardour'" },
	{ "ams", ladish_snewapp .. "ams 'ams' 0" },
	{ "non-sequencer", ladish_snewapp .. "non-sequencer 'non-sequencer' lash" },
	{ "seq24 sequencer", ladish_snewapp .. "seq24 'seq24 sequencer' lash" },
	{ "bristol mini", ladish_snewapp .. "'startBristol -mini' 'bristol mini' 0" },
	{ "yoshimi synth", ladish_snewapp .. "'yoshimi -j -J' 'yoshimi synth' lash" },
	{ "minicomputer synth", ladish_snewapp .. "minicomputer 'minicomputer synth' 0" },
	{ "lv2 synth host", ladish_snewapp .. "zynjacku 'lv2 synth host' 0" },
	{ "lv2 fx host", ladish_snewapp .. "lv2rack 'lv2 fx host' 0" },
	{ "calf synth/fx host", ladish_snewapp .. "calfjackhost 'calf host' lash" },
	{ "carla synth/fx host", ladish_snewapp .. "carla 'carla host' 0" },
	{ "jconvolver", ladish_snewapp .. "Jc_Gui 'jconvolver' 0" },
	{ "hydrogen", ladish_snewapp .. "hydrogen 'hydrogen' lash" },
	{ "sooperlooper", ladish_snewapp .. "slgui 'sooperlooper' 0" },
	{ "zita autotuner", ladish_snewapp .. "zita-at1 'zita autotuner' 0" },
	{ "zita reverb", ladish_snewapp .. "zita-rev1 'zita reverb' 0" },
	{ "traditional vu meter", ladish_snewapp .. "'jmeters -t vu system:capture_1 system:capture_2' 'vu meter' 0" },
	{ "graphical volume meter", ladish_snewapp .. "jkmeter 'volume meter' 0" },
	{ "audio analyzer", ladish_snewapp .. "'jaaa -J' 'audio analyzer' 0"},
	--{ "linuxsampler", ladish_snewapp .. "qsampler 'linuxsampler' 0" },
	--{ "tapeutape sampler", ladish_snewapp .. "tapeutape 'tapeutape sampler' 0" },
	{ "fluidsynth sampler", ladish_snewapp .. "qsynth 'fluidsynth sampler' lash" },
	{ "virtual keyboard", ladish_snewapp .. "jack-keyboard 'virtual keyboard' 0" },
	{ "jamin mastering suite", ladish_snewapp .. "jamin 'jamin' 0" },
	{ "--" },
	{ "utilities", myutilsmenu},
	{ "system", mysystemmenu},
	}
})
