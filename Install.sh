#!/bin/bash

cd /
loadkeys la-latin1;
iwctl;
input("All good? (Ctrl-C if not)")
timedatectl set-ntp true;
fdisk -l;
echo "Which Disk are you going to use?(sdx)
(For now this program only uses the first three partitions as:
esp, root, swap)";
UD = input("Disk: ");
fdisk -l /dev/${UD}
echo "The partitions used are going to be:
EFI system partition: /dev/${UD}1
Root: /dev/${UD}2
Swap: /dev/${UD}3";
input("All good? (Ctrl-C if not)")

mkfs.fat -F32 /dev/${UD}1;
mkfs.ext4     /dev/${UD}2;
mkswap        /dev/${UD}3;
input("All good? (Ctrl-C if not)")

mount         /dev/${UD}2 /mnt
mkdir         /mnt/efi
mount         /dev/${UD}1 /mnt/efi
swapon        /dev/${UD}3
input("All good? (Ctrl-C if not)")

pacstrap /mnt base linux linux-firmware vim linux-headers man-db man-pages texinfo networkmanager coreutils
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
input("All good? (Ctrl-C if not)")

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
hwclock --systohc

vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
cat /etc/locale.conf
input("All good? (Ctrl-C if not)")

echo "KEYMAP=la-latin1" >> vim /etc/vconsole.conf
cat /etc/vconsole.conf
input("All good? (Ctrl-C if not)")

echo Arxchel >> /etc/hostname
cat /etc/hostname
input("All good? (Ctrl-C if not)")

echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	      localhost" >> /etc/hosts
echo "127.0.1.1	Arxchel.xch   Arxchel" >> /etc/hosts
cat /etc/hosts
input("All good? (Ctrl-C if not)")

pacman -S intel-ucode xorg mesa xf86-video-nouveau lightdm git awesome ddrescue efibootmgr grub
systemctl enable NetworkManager
systemctl enable lightdm
input("All good? (Ctrl-C if not)")

mkinitcpio -P
input("All good? (Ctrl-C if not)")

grub-install --target=x86_64-efi --efi-directory=/efi --removable --bootloader-id=GRUB
input("All good? (Ctrl-C if not)")
grub-mkconfig -o /boot/grub/grub.cfg
