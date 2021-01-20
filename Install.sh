#!/bin/bash

loadkeys la-latin1;
iwctl;
timedatectl set-ntp true;
fdisk -l;
echo "Which Disk are you going to use?(sdx)
(For now this program only uses the first three partitions as:
esp, root, swap)";
UD = input("Disk: ");
echo "The partitions used are going to be:
EFI system partition: /dev/${UD}1
Root: /dev/${UD}2
Swap: /dev/${UD}3";

mkfs.fat -F32 /dev/${UD}1;
mkfs.ext4     /dev/${UD}2;
mkswap        /dev/${UD}3;

mount         /dev/${UD}2 /mnt
mkdir         /mnt/efi
mount         /dev/${UD}1 /mnt/efi
swapon        /dev/${UD}3

pacstrap /mnt base linux linux-firmware vim linux-headers man-db man-pages texinfo networkmanager coreutils
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
hwclock --systohc

vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "KEYMAP=la-latin1" >> vim /etc/vconsole.conf

echo Arxchel >> /etc/hostname

echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	      localhost" >> /etc/hosts
echo "127.0.1.1	Arxchel.xch   Arxchel" >> /etc/hosts

pacman -S intel-ucode xorg mesa xf86-video-nouveau lightdm awesome ddrescue efibootmgr grub
systemctl enable NetworkManager
systemctl enable lightdm

mkinitcpio -P

grub-install --target=x86_64-efi --efi-directory=/efi --removable --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
