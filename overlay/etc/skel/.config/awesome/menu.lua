-- Aweosme menu file
-- This file is included into the main rc.lua file to build the main menu.

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
ladish_snewapp = "python2 /usr/bin/ladish_control snewapp"


-- keep track of apps in a single array to build menus & wm rules
-- { name, command, ladish compatibility level, run in terminal, float }
ladish_apps = {
	{ "ardour", "ardour2", 0, false, false },
	{ "ams", "ams", 0, false, false },
	{ "non midi sequencer", "non-sequencer", 0, false, false },
	{ "seq24 midi sequencer", "seq24", 0, false, false },
	{ "bristol mini", "'startBristol -mini'", 0, false, true },
	{ "yoshimi synth", "'yoshimi -j -J'", 0, false, true },
	{ "minicomputer synth", "minicomputer", 0, false, true },
	{ "lv2 synth host", "zynjacku", 0, false, true },
	{ "lv2 fx host", "lv2rack", 0, false, true },
	{ "calf synth/fx host", "calfjackhost", 0, false, true },
	{ "jconvolver", "Jc_Gui", 0, false, true },
	{ "hydrogen", "hydrogen", 0, false, false },
	{ "zita autotuner", "zita-at1", 0, false, true },
	{ "zita reverb", "zita-rev1", 0, false, true },
	{ "traditional vu meter", "'jmeters -t vu system:capture_1 system:capture_2'", 0, false, true },
	{ "graphical volume meter", "jkmeter", 0, false, true },
	{ "audio analyzer", "'jaaa -J'", 0, false, false },
	--{ "linuxsampler", ladish_snewapp .. "qsampler", 0, false, false },
	{ "virtual keyboard", "jack-keyboard", 0, false, false },
	{ "jamin mastering suite", "jamin", 0, false, false },
}

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

mainmenuitems = { { "-+=Menu=+-", ""} }

for menuitem in ladish_apps do
	if menuitem[4] then
		term = " term"
	else
		term = ""
	end

	itemcommand = ladish_snewapp .. " \"" menuitem[2] .. "\" \"" .. menuitem[1] .. "\" " .. menuitem[3] .. term

	mainmenuitems = awful.util.table.join(mainmenuitems, { menuitem[1], itemcommand } )
end

mainmenuitems = awful.util.table.join(
	mainmenuitems, 
	{ "--" , "" },
	{ "utilities", myutilsmenu},
	{ "system", mysystemmenu},
 )

mymainmenu = awful.menu.new(
	{ items = mainmenuitems }
})
