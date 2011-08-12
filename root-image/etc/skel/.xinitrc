SESSION_TYPE=awesome

(sleep 5 && laditray) &

if [ "$SESSION_TYPE" = "awesome" ]; then
	exec awesome
elif [ "$SESSION_TYPE" = "openbox" ]; then
	tint2 &
	exec openbox
fi
