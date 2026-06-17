/bin/sh -c ~/.config/autostart/init.sh
/bin/sh -c ~/.config/i3/auto_start.sh
i3
# /github_dir/dwm/dwm
# awesome
$HOME/.monicarc   #monitor calibration
# exec qtile start

xrdb ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# DEFAULT_SESSION=/github_dir/dwm/dwm
DEFAULT_SESSION=i3
case $1 in
 awesome|wmii|xmonad) exec $1 ;;
 *) exec $DEFAULT_SESSION ;;
esac

~/.fehbg &


