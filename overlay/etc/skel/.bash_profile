. $HOME/.bashrc

OOO_FORCE_DESKTOP=gnome
export OOO_FORCE_DESKTOP

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx 2> .xsession-errors
  logout
fi

