#!/bin/sh

UNAME=$(sed -n '/USR/{s/USR://; s/:.*//; p; q;}' upass.txt)
UPASS=$(sed -n '/USR/{s/USR:.*://; p; q;}' upass.txt)

RNAME=root
RPASS=$(sed -n '/ROOT/{s/ROOT:.*://; p; q;}' upass.txt)



echo $UPASS | sudo -S dhcpcd $(ip link | sed -n '/enp0s/{s/2: //; s/:.*//; p;}')


sudo touch /etc/udev/rules.d/90-xhc_sleep.rules
echo -e 'disable wake from S3 on XHC1\nSUBSYSTEM=="pci", KERNEL=="0000:00:14.0", ATTR{power/wakeup}="disabled"' | sudo tee -a /etc/udev/rules.d/90-xhc_sleep.rules

# Install yay from git (install git first)
sudo pacman --noconfirm -S git
cd /tmp/
git clone https://aur.archlinux.org/yay.git
cd ./yay
makepkg --noconfirm -si
cd

yay --noconfirm -S broadcom-wl

# Optional
sudo systemctl disable dhcpcd
sudo pacman --noconfirm -S networkmanager # network-manager-applet
sudo systemctl enable NetworkManager
# (End optional)

yay --noconfirm -S mbpfan-git cpupower
sudo systemctl enable mbpfan
sudo systemctl enable cpupower

# vim /etc/default/cpupower

echo -e "# Define CPUs governor\ngovernor='powersave'" | sudo tee -a /etc/default/cpupower

yay --noconfirm -S alsa-utils

# vim /etc/modprobe.d/snd_hda_intel.conf
sudo touch /etc/modprobe.d/snd_hda_intel.conf
echo -e "# Switch audio output from HDMI to PCH and Enable sound chipset powersaving\noptions snd-hda-intel index=1,0 power_save=1" | sudo tee -a /etc/modprobe.d/snd_hda_intel.conf

reboot