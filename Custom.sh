cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd /
rm -r /tmp/yay

yay -Syyu
yay -S `cat software`

sudo systemctl enable lightdm
sudo systemctl enable NetworkManager
good

sudo mkinitcpio -P
good

echo "Is the system removable?[N,y]"
read R

if [ $R == "y" -o $R == "Y" ]; then
  sudo grub-install --target=x86_64-efi --efi-directory=/efi --removable --bootloader-id=GRUB
else
  sudo grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
fi
good

echo "Do you want a kickass fallout grub theme?(Not mine)[N,y]"
read R

if [ $R == "y" -o $R == "Y" ]; then
  wget -O - https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash
fi
good

sudo grub-mkconfig -o /boot/grub/grub.cfg
good

echo "Your minimal system is installed!
Recomendations:
Check for any problem in
    check /etc/locale.gen
    check /etc/locale.conf
    check /etc/vconsole
    check /etc/hosts
    check /etc/hostname
    check /etc/fsck
And add:
    Your user --- to /etc/sudoers
    Default insults --- to /etc/sudoers (With tab)
    asciiquarium, cowsay, fortune-mod, sl, oneko
    uncomment the multilib ----- in /etc/pacman.conf
    ILoveCandy ---------- in /etc/pacman.conf
    cows to /usr/share/cows from https://github.com/paulkaefer/cowsay-files
    cbonsai asciiquarium
"
rm -r /Archinstall
echo "Program finished, Bye!"
