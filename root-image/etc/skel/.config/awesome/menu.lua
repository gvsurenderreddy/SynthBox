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

mybristolmenu = {
	{ "moog mini", ladish_snewapp .. "'startBristol -mini' 'bristol mini' 0" },
	{ "moog voyager", ladish_snewapp .. "'startBristol -explorer' 'bristol voyager' 0" },
	{ "moog voyager electric blue", ladish_snewapp .. "'startBristol -voyager' 'bristol voyager electric blue' 0" },
	{ "moog memory", ladish_snewapp .. "'startBristol -memory' 'bristol memory' 0" },
	{ "moog sonic 6", ladish_snewapp .. "'startBristol -sonic6' 'bristol sonic 6' 0" },
	{ "moog mg-1 concertmate", ladish_snewapp .. "'startBristol -mg1' 'bristol mg-1 concertmate' 0" },
	{ "hammond b3", ladish_snewapp .. "'startBristol -b3' 'bristol hammond B3' 0" },
	{ "seq. circuits prophet-5", ladish_snewapp .. "'startBristol -prophet' 'bristol prophet-5' 0" },
	{ "seq. circuits prophet-5/fx", ladish_snewapp .. "'startBristol -pro52' 'bristol prophet-5/fx' 0" },
	{ "seq. circuits prophet-10", ladish_snewapp .. "'startBristol -pro10' 'bristol prophet-10' 0" },
	{ "seq. circuits pro-one", ladish_snewapp .. "'startBristol -pro1' 'bristol pro-one' 0" },
	{ "fender rhodes piano", ladish_snewapp .. "'startBristol -rhodes' 'bristol rhodes piano' 0" },
	{ "fender rhodes bass", ladish_snewapp .. "'startBristol -rhodesbass' 'bristol rhodes bass' 0" },
	{ "crumar roadrunner", ladish_snewapp .. "'startBristol -roadrunner' 'bristol roadrunner' 0" },
	{ "crumar bit 01", ladish_snewapp .. "'startBristol -bitone' 'bristol bit 01' 0" },
	{ "crumar bit 99", ladish_snewapp .. "'startBristol -bit99' 'bristol bit 99' 0" },
	{ "crumar bit + mods", ladish_snewapp .. "'startBristol -bit100' 'bristol bit + mods' 0" },
	{ "crumar stratus", ladish_snewapp .. "'startBristol -stratus' 'bristol stratus' 0" },
	{ "crumar trilogy", ladish_snewapp .. "'startBristol -trilogy' 'bristol trilogy' 0" },
	{ "oberheim OB-X", ladish_snewapp .. "'startBristol -obx' 'bristol OB-X' 0" },
	{ "oberheim OB-Xa", ladish_snewapp .. "'startBristol -obxa' 'bristol OB-Xa' 0" },
	{ "arp axxe", ladish_snewapp .. "'startBristol -axxe' 'bristol arp axxe' 0" },
	{ "arp odyssey", ladish_snewapp .. "'startBristol -odyssey' 'bristol odyssey' 0" },
	{ "arp 2600", ladish_snewapp .. "'startBristol -arp2600' 'bristol arp 2600' 0" },
	{ "arp solina", ladish_snewapp .. "'startBristol -solina' 'bristol solina' 0" },
	{ "korg polysix", ladish_snewapp .. "'startBristol -polysix' 'bristol polysix' 0" },
	{ "korg poly-800", ladish_snewapp .. "'startBristol -poly800' 'bristol poly-800' 0" },
	{ "korg mono/poly", ladish_snewapp .. "'startBristol -monopoly' 'bristol mono/poly' 0" },
	{ "vox continental", ladish_snewapp .. "'startBristol -vox' 'bristol vox continental' 0" },
	{ "vox cont. super/300/II", ladish_snewapp .. "'startBristol -voxM2' 'bristol vox cont. super/300/II' 0" },
	{ "roland juno-60", ladish_snewapp .. "'startBristol -juno' 'bristol juno-60' 0" },
	{ "roland jupiter-8", ladish_snewapp .. "'startBristol -jupiter' 'bristol jupiter-8' 0" },
	{ "baumann bme-700", ladish_snewapp .. "'startBristol -bme700' 'bristol bme-700' 0" },
	{ "yamaha dx-7", ladish_snewapp .. "'startBristol -dx' 'bristol dx-7' 0" },
	{ "commodore 64 SID synth", ladish_snewapp .. "'startBristol -sidney' 'bristol commodore 64 SID synth' 0" },
}

mymainmenu = awful.menu.new(
	{ items = { 
	{ "-+=Menu=+-", ""},
	--{ "ardour", ladish_snewapp .. "ardour2 'ardour'" },
	{ "ams", ladish_snewapp .. "ams 'ams' 0" },
	{ "non-sequencer", ladish_snewapp .. "non-sequencer 'non-sequencer' lash" },
	{ "seq24 sequencer", ladish_snewapp .. "seq24 'seq24 sequencer' lash" },
	{ "bristol synths", mybristolmenu },
	{ "yoshimi synth", ladish_snewapp .. "'yoshimi -j -J' 'yoshimi synth' lash" },
	{ "minicomputer synth", ladish_snewapp .. "minicomputer 'minicomputer synth' 0" },
	{ "lv2 synth host", ladish_snewapp .. "zynjacku 'lv2 synth host' 0" },
	{ "lv2 fx host", ladish_snewapp .. "lv2rack 'lv2 fx host' 0" },
	{ "calf synth/fx host", ladish_snewapp .. "calfjackhost 'calf host' lash" },
	{ "carla synth/fx host", ladish_snewapp .. "carla 'carla host' 0" },
	{ "jconvolver", ladish_snewapp .. "Jc_Gui 'jconvolver' 0" },
	{ "hydrogen", ladish_snewapp .. "hydrogen 'hydrogen' lash" },
	{ "sooperlooper", ladish_snewapp .. "slgui 'sooperlooper' 0" },
	{ "puredata extended", ladish_snewapp .. "pdextended 'puredata extended' " },
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
