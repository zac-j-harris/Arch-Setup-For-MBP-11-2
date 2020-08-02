#!/bin/sh

# arch-chroot /

ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc
# Uncomment locale in /etc/locale.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# root passwd
# echo "What... is your computer's quest? (Hostname)" && read HOSTNAME
HOSTNAME=testhost
echo $HOSTNAME > /etc/hostname
# echo "What... is the capital of Assyria? (Root Password)" && read ROOTPASS
ROOTPASS=toor
echo "root:$ROOTPASS" | chpasswd
# vim /etc/hosts
echo -e "127.0.0.1   localhost\n::1     localhost\n127.0.1.1   $HOSTNAME.localdomain  $HOSTNAME" >> /etc/hosts

# usr passwd
# echo "What... is your quest? (Username)" && read USRNAME
USRNAME=testusr
# echo "What... is your favorite color? (User Password)" && read USRPASS
USRPASS=toor
groupadd sudo
useradd -m -g users -G wheel -s /bin/bash $USRNAME
echo "$USRNAME:$USRPASS" | chpasswd
usermod -aG sudo root
usermod -aG sudo $USRNAME
# vim /etc/sudoers
echo "%sudo ALL=(ALL) ALL" >> /etc/sudoers
	
# vim /etc/modules
echo -e "coretemp\napplesmc" > /etc/modules

bootctl --path=/boot install

# vim /boot/loader/entries/arch.conf

echo -e "title Arch Linux\nlinux /vmlinuz-linux\ninitrd /intel-ucode.img\ninitrd /initramfs-linux.img\noptions root=/dev/sda3 intel_iommu=on" > /boot/loader/entries/arch.conf

# vim /boot/loader/loader.conf

echo "default arch-*" > /boot/loader/loader.conf

echo -e "USR:$USRNAME:$USRPASS\nROOT:root:$ROOTPASS" > /home/$USRNAME/upass.txt

mv /home/runnable* /home/$USRNAME/

chmod +x /home/$USRNAME/runnable*

chown -R $USRNAME /home/$USRNAME

# exit

# umount -R /mnt









