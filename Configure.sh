#!/bin/bash

check () {
  if [ $1 != 0 ]; then
    echo "Last command did not end well, exiting"
    exit 2
  fi
}

good () {
  echo "All good?[Y,n]"
  read R
  if [ $R == "n" -o $R == "N" ]; then
    exit 1
  fi
}

cd /
ls -d /usr/share/zoneinfo/*/
echo "What is your area?(Use name only, with capitals)"
read area
if [ $? != 0 ]; then
  echo "Not understood, using America"
  area = America
fi
ls -d /usr/share/zoneinfo/$area/*/
echo "What is your city?(Use name only, with capitals)"
read city
if [ $? != 0 ]; then
  echo "Not understood, using Mexico_City"
  city = Mexico_City
fi

ln -sf /usr/share/zoneinfo/$area/$city /etc/localtime
check $?
hwclock --systohc
check $?

echo "English locale will be used
If you want another, please change the files /etc/locale.gen and /etc/locale.conf accordingly"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
cat /etc/locale.conf
echo "You should see the language of the locale"
good

echo "KEYMAP=`localectl status | grep -i key | cut -d " " -f 10-`" > /etc/vconsole.conf
cat /etc/vconsole.conf
echo "You should see the keyboard map"
good

echo "What is your hostname?(No spaces)"
read HN
echo "And your domain?(No spaces)"
read HD

echo $HN > /etc/hostname
cat /etc/hostname
echo "You should see the hostname"
good
echo "# Static table lookup for hostnames.
# See hosts(5) for details.
127.0.0.1	localhost
::1	     localhost
127.0.1.1	$HN.HD   HN" > /etc/hosts
cat /etc/hosts
echo "You should see the local hosts and host name"
good

echo "This only installs everything necesary for a pc with intel processors
and nvidia GPU, it installs the free \"Nouveau\" drivers for efi driven computers.
It also installs the lts linux version"
good
pacman -Syyu
pacman -S intel-ucode xorg mesa xf86-video-nouveau efibootmgr grub
pacman -S linux-lts linux-lts-headers base-devel net-tools ntfs-3g
pacman -S git ddrescue vim networkmanager coreutils linux-tools curl wget kitty
echo "Do you want a desktop environment?(The one used here is plasma with lightdm)[Y,n]"
read R
if [ $R != "n" -a $R != "N" ]; then
  pacman -S plasma lightdm{,-{gtk,webkit2}-greeter}
  pacman -R sddm-kcm
  pacman -R sddm
  systemctl enable lightdm
fi
systemctl enable NetworkManager
good

mkinitcpio -P
good

echo "Is the system removable?[N,y]"
read R

if [ $R == "y" -o $R == "Y" ]; then
  grub-install --target=x86_64-efi --efi-directory=/efi --removable --bootloader-id=GRUB
else
  grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
fi
good

echo "Do you want a kickass fallout grub theme?(Not mine)[N,y]"
read R

if [ $R == "y" -o $R == "Y" ]; then
  wget -O - https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash
fi
good

echo "Do you want access to the AUR?[Y,n]"
read R

if [ $R != "n" -a $R != "N" ]; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd /
  rm -r /tmp/yay
  yay -Syyu
fi
good

grub-mkconfig -o /boot/grub/grub.cfg
good

echo "Now create your root password:"
passwd
echo "what's your user's name?"
read U
echo "The user: $U will be created"
useradd -m $U
check $?
echo "Does it need a password?[Y,n]"
read R
if [$R != "n" -a $R != "N"]; then
  echo "What's the password?"
  passwd $U
  check
fi

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
