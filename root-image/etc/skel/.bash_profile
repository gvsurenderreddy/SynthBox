#Use the home dir on the usb stick if it exists
. /etc/rc.conf
if [ -L "$HOME/$USB_CONFIG_DIR_NAME" ]; then
  export HOME="$HOME/$USB_CONFIG_DIR_NAME"
fi

. $HOME/.bashrc

OOO_FORCE_DESKTOP=gnome
export OOO_FORCE_DESKTOP

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx &> .xsession-errors
  #logout
fi

