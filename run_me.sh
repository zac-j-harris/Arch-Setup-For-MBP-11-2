#!/bin/sh

dhcpcd "$(ip link | grep enp0s)"
timedatectl set-ntp true
# Make 2 partitions
# fdisk /dev/sda
# Make swap and ext4
# Write
# fdisk -p
# echo "Which partition ..."
mkswap /dev/sda4
swapon /dev/sda4
mkfs.ext4 /dev/sda5
mount /dev/sda5 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
# Install stuff
pacstrap /mnt base base-devel linux linux-firmware dhcpcd vim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
# Change options for root partition to rw,relatime,data=ordered,discard
sed 's/ext4       rw,relatime/&,data=ordered,discard/' /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc
# Uncomment locale in /etc/locale.gen
sed 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "What is your quest?" && read HOSTNAME
echo $HOSTNAME > /etc/hostname
# vim /etc/hosts
echo -e "127.0.0.1   localhost\n::1     localhost\n127.0.1.1   $HOSTNAME.localdomain  $HOSTNAME" >> /etc/hosts

passwd
groupadd sudo
useradd -m -g users -G wheel -s /bin/bash you
passwd you
usermod -aG sudo root
usermod -aG sudo you
vim /etc/sudoers
vim /etc/modules

coretemp
applesmc

bootctl --path=/boot install
vim /boot/loader/entries/arch.conf

title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=/dev/sda1 intel_iommu=on

vim /boot/loader/loader.conf

Comment whatever isnt
default arch-*

exit
umount -R /mnt
reboot







