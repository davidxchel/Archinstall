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

pacman -S intel-ucode efibootmgr grub

mkinitcpio -P

grub-install --target=x86_64-efi --efi-directory=/efi --removable --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
