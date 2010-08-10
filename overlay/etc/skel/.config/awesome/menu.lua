-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor


-- Create a laucher widget and a main menu
myawesomemenu = {
   { "htop", terminal .. " -e htop" },
   { "alsamixer", terminal .. " -e alsamixer" },
   --{ "sensors", terminal .. " -e watch sensors" },
   { "sensors", "/home/sean/.scripts/sensors-notify.sh" },
   { "config screensaver", "xscreensaver-demo" },
   { "deactivate screensaver", "xscreensaver-command -exit" },
   { "start screensaver", "xscreensaver-command -activate" },
   { "xdiskusage", "xdiskusage" },
   { "--" },
   { "awesome manual", terminal .. " -e man awesome" },
   { "edit awesome config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "--" },
   { "restart awesome", awesome.restart },
   { "quit awesome (logoff)", awesome.quit },
   { "shutdown", terminal .. " -e sudo poweroff" },
   { "reboot", terminal .. " -e sudo reboot" },
}

mygamesmenu = {
	{ "battle for wesnoth", "wesnoth", "/usr/share/icons/wesnoth-icon.png" },
	{ "cave story", "doukutsu", "/usr/share/icons/doukutsu.png" },
	{ "emulator chooser", terminal .. " -e emuchooser.sh", "/usr/share/icons/stella.png" },
	{ "vice c64", "x64" },
}

mymainmenu = awful.menu.new({ items = { { "terminal", terminal, "/usr/share/icons/Tango/24x24/apps/terminal.png" },
                                        { "gimp", "gimp", "/usr/share/icons/hicolor/48x48/apps/gimp.png" },
										{ "gnucash", "gnucash", "/usr/share/icons/hicolor/48x48/apps/gnucash-icon.png" },
										{ "geany", "geany", "/usr/share/icons/Tango/24x24/apps/text-editor.png"  },
										{ "ardour", "ardour2", "/usr/share/ardour2/icons/ardour_icon_48px.png"  },
										{ "audacity", "audacity" },
										{ "patchage", "patchage", "/usr/share/pixmaps/patchage.png"  },
										{ "jconv", terminal .. " -title jconv -e /usr/local/bin/jconv-confpicker.sh" },
										{ "hydrogen", "hydrogen" },
										{ "jamin", "jamin", "/usr/share/jamin/pixmaps/JAMin_icon.xpm"  },
										{ "renoise", "renoise", "/usr/share/icons/hicolor/48x48/apps/renoise.png"  },
										{ "thunar", "thunar", "/usr/share/icons/Tango/24x24/apps/file-manager.png" },
										{ "mc", terminal .. " -e mc" },
										--{ "ristretto", "ristretto", "/usr/share/icons/Tango/24x24/mimetypes/image-x-generic.png" },
										{ "firefox", "firefox", "/usr/share/pixmaps/firefox.png" },
										{ "pidgin", "pidgin", "/usr/share/icons/hicolor/48x48/apps/pidgin.png" },
										{ "alpine", terminal .. " -e alpine", "/usr/share/icons/Tango/24x24/apps/internet-mail.png" },
										{ "gftp", "gftp", "/usr/share/icons/Tango/24x24/apps/system-software-update.png" },
										--{ "audacious", "audacious2", "/usr/share/audacious/images/audacious_player.xpm" },
										--{ "exaile", "exaile", "/usr/share/exaile/data/images/exailelogo.png" },
										{ "moc", terminal .. " -e mocp" },
										{ "grip", "grip" },
										{ "ogmrip", "ogmrip /dev/sr0" },
										{ "gpodder", "gpodder", "/usr/share/pixmaps/gpodder.png" },
										{ "graveman", "graveman" },
										{ "openoffice", "ooffice", "/usr/share/icons/Tango/24x24/categories/applications-office.png"  },
										{ "python", terminal .. " -e bpython" },
										{ "games", mygamesmenu, "/usr/share/icons/Tango/24x24/categories/applications-games.png" },
										{ "system", myawesomemenu, beautiful.awesome_icon },
                                      }
                            })
