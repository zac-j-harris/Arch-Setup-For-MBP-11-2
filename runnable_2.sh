#!/bin/sh

# speaker-test -c 2

UNAME=$(sed -n '/USR/{s/USR://; s/:.*//; p; q;}' upass.txt)
UPASS=$(sed -n '/USR/{s/USR:.*://; p; q;}' upass.txt)

RNAME=root
RPASS=$(sed -n '/ROOT/{s/ROOT:.*://; p; q;}' upass.txt)

yay --noconfirm -S xorg-server xorg-xrandr xorg-xinit xorg-xset xterm(maybe) xf86-video-intel sxhkd bspwm tmux xorg-xclock neofetch

# sudo chown -r you ~/you

# vim /etc/X11/xorg.conf.d/30-touchpad.conf
echo $UPASS | sudo touch /etc/X11/xorg.conf.d/30-touchpad.conf
echo -e 'Section "InputClass"\n    Identifier "touchpad"\n    Driver "libinput"\n    MatchIsTouchpad "on"\n    Option "Tapping" "on"\n    Option "NaturalScrolling" "true"\n    Option "ClickMethod" "clickfinger"\n    Option "AccelProfile" "flat"\nEndSection' | sudo tee -a /etc/X11/xorg.conf.d/30-touchpad.conf


# vim /etc/X11/xorg.conf.d/30-pointer.conf
sudo touch /etc/X11/xorg.conf.d/30-pointer.conf
sudo echo -e 'Section "InputClass"\n    Identifier "pointer"\n    Driver "libinput"\n    MatchIsPointer "on"\n    Option "NaturalScrolling" "true"\nEndSection' | sudo tee -a /etc/X11/xorg.conf.d/30-pointer.conf

# vim ~/.Xresources
touch ~/.Xresources
echo -e 'Xft.dpi: 190\nXft.autohint: 0\nXft.lcdfilter:  lcddefault\nXft.hintstyle:  hintfull\nXft.hinting: 1\nXft.antialias: 1\nXft.rgba: rgb' | tee -a ~/.Xresources
# | sudo tee -a
# vim ~/.xinitrc

touch ~/.xinitrc
echo -e '# Adjust keyboard typematic delay and rate\nxset r rate 270 30\n# Start Xorg server at this DPI\nxrandr --dpi 190\n# Merge & load configuration from .Xresources\nxrdb -merge ~/.Xresources\n# Let QT and GTK autodetect retina screen and autoadjust\nexport QT_AUTO_SCREEN_SCALE_FACTOR=1\nexport GDK_SCALE=2\nexport GDK_DPI_SCALE=0.5\n# Finally start our WM\nbspwm &\nxclock -g 50x50-0+0 -bw 0&\nxload -g 50x50-50+0 -bw 0&\nxterm -g 80x24+0+0&\nexec xterm -g 80x24+0-0' | tee -a ~/.xinitrc

mkdir ~/.config/bspwm
mkdir ~/.config/sxhkd

cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

echo "Recommended to now type 'startx'"
