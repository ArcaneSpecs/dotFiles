$HOME/.monicarc   #monitor calibration
exec qtile start

xrdb ~/.Xresources

DEFAULT_SESSION=awesome
case $1 in
 awesome|wmii|xmonad) exec $1 ;;
 *) exec $DEFAULT_SESSION ;;
esac

~/.fehbg &


