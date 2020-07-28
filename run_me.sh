#!/bin/sh

dhcpcd "$(ip link | grep enp0s)"
timedatectl set-ntp true

curl -JLO https://raw.github.com/zac-j-harris/Arch-Setup-For-MBP-11-2/dev/runnable_0.sh
curl -JLO https://raw.github.com/zac-j-harris/Arch-Setup-For-MBP-11-2/dev/runnable_1.sh
curl -JLO https://raw.github.com/zac-j-harris/Arch-Setup-For-MBP-11-2/dev/runnable_2.sh
# Make 2 partitions
# fdisk /dev/sda
# Make swap and ext4
# Write
# fdisk -p
# echo "Which partition ..."
mkswap -F /dev/sda4
swapon /dev/sda4
mkfs.ext4 -F /dev/sda5
mount /dev/sda5 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
# Install stuff
pacstrap /mnt base base-devel linux linux-firmware dhcpcd vim
pacstrap /mnt intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
# Change options for root partition to rw,relatime,data=ordered,discard
sed -i 's/ext4       rw,relatime/&,data=ordered,discard/' /mnt/etc/fstab
mv ./runnable* /mnt/home/
# arch-chroot /mnt

chmod +x /mnt/home/runnable*

/mnt/home/runnable_0.sh
