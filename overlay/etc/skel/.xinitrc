alsactl restore
(sleep 5 && laditray) &

eval $(dbus-launch --sh-syntax --exit-with-session)
exec ck-launch-session awesome
