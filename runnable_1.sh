#!/bin/sh

UNAME=$(sed -n '/USR/{s/USR://; s/:.*//; p; q;}' upass.txt)
UPASS=$(sed -n '/USR/{s/USR:.*://; p; q;}' upass.txt)

RNAME=root
RPASS=$(sed -n '/ROOT/{s/ROOT:.*://; p; q;}' upass.txt)



sudo dhcpcd "$(ip link | grep enp0s)"

UPASS

sudo echo -e 'disable wake from S3 on XHC1\nSUBSYSTEM=="pci", KERNEL=="0000:00:14.0", ATTR{power/wakeup}="disabled"' > /etc/udev/rules.d/90-xhc_sleep.rules

# Install yay from git (install git first)
sudo pacman -S git
cd /tmp/
git clone https://aur.archlinux.org/yay.git
cd ./yay
makepkg -si
cd

yay -S broadcom-wl

# Optional
sudo systemctl disable dhcpcd
sudo pacman -S networkmanager # network-manager-applet
sudo systemctl enable NetworkManager
# (End optional)

yay -S mbpfan-git cpupower
sudo systemctl enable mbpfan
sudo systemctl enable cpupower

# vim /etc/default/cpupower

sudo echo -e "# Define CPUs governor\ngovernor='powersave'" >> /etc/default/cpupower

yay -S alsa-utils

# vim /etc/modprobe.d/snd_hda_intel.conf

sudo echo -e "# Switch audio output from HDMI to PCH and Enable sound chipset powersaving\noptions snd-hda-intel index=1,0 power_save=1" > /etc/modprobe.d/snd_hda_intel.conf

reboot