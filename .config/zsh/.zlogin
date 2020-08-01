# Auto startx if tty1
if [[ -z $DISPLAY ]] && (( $EUID != 0 )) {
    [[ ${TTY/tty} != $TTY ]] && (( ${TTY:8:1} <= 1 )) &&
        startx ~/.config/X11/xinitrc &
}
