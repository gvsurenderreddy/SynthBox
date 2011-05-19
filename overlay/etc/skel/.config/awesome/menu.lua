-- Aweosme menu file
-- This file is included into the main rc.lua file to build the main menu.

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor


-- Create a laucher widget and a main menu

myaudiomenu = {
	{ "ardour", "ardour2" },
	{ "jconvolver", "Jc_Gui" },
	{ "hydrogen", "hydrogen" },
	{ "qsampler", "qsampler" },
	{ "vmpk", "vmpk" },
	{ "jamin", "jamin" },
	{ "--" },
	{ "gladish", "gladish" },
	{ "alsamixer", terminal .. " -e alsamixer" },
}

mysystemmenu = {
	{ "gtk2 theme switcher", "gtk-theme-switch2" },
	{ "--" },
	{ "awesome manual", terminal .. " -e man awesome" },
	{ "edit awesome config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
	{ "edit awesome menu", editor_cmd .. " " .. awful.util.getdir("config") .. "/menu.lua" },
	{ "--" },
	{ "restart awesome", awesome.restart },
	{ "quit awesome (logoff)", awesome.quit },
	{ "shutdown", terminal .. " -e sudo poweroff" },
	{ "reboot", terminal .. " -e sudo reboot" },
}

mymainmenu = awful.menu.new(
	{ items = { 
		{ "-+=Menu=+-", ""},
		{ "terminal", terminal},
		{ "file manager", "thunar"},
		{ "browser", "firefox"},
		{ "audio", myaudiomenu},
		{ "system", mysystemmenu},
	}
})
