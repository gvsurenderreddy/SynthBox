SESSION_TYPE=awesome

#(sleep 5 && laditray) &

if [ "$SESSION_TYPE" = "awesome" ]; then
	exec ck-launch-session awesome
elseif [ "$SESSION_TYPE" = "openbox" ]; then
	tint2 &
	exec ck-launch-session openbox
fi
