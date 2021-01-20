cd /

ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
hwclock --systohc

vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
cat /etc/locale.conf
echo "All good? (Ctrl-C if not)"

echo "KEYMAP=la-latin1" >> vim /etc/vconsole.conf
cat /etc/vconsole.conf
echo "All good? (Ctrl-C if not)"

echo Arxchel >> /etc/hostname
cat /etc/hostname
echo "All good? (Ctrl-C if not)"

echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	      localhost" >> /etc/hosts
echo "127.0.1.1	Arxchel.xch   Arxchel" >> /etc/hosts
cat /etc/hosts
echo "All good? (Ctrl-C if not)"

pacman -S intel-ucode xorg mesa xf86-video-nouveau lightdm git awesome ddrescue efibootmgr grub
systemctl enable NetworkManager
systemctl enable lightdm
echo "All good? (Ctrl-C if not)"

mkinitcpio -P
echo "All good? (Ctrl-C if not)"

grub-install --target=x86_64-efi --efi-directory=/efi --removable --bootloader-id=GRUB
echo "All good? (Ctrl-C if not)"
grub-mkconfig -o /boot/grub/grub.cfg
