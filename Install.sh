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
echo "Do you want to use la-latin1 keys?[Y,n]"
read R
if [ $R == "n" -o $R == "N" ]; then
    echo "Which one do you want?"
    read R
else
    R = la-latin1
fi
echo "Using $R"
loadkeys $R
echo "Checking keys"
check $?

timedatectl set-ntp true
lsblk
fdisk -l
echo "Which disk are you going to use? (just the letter)"
read disk
echo "Disk:"
fdisk -l /dev/s$disk
echo "Checking disk"
check $?

echo "Which partition are you going to use for the EFI? (just the number)
Note: This has to start in the sector number 2048 and be at least 250 MB
If you do not wish to continue put any letter here!"
read efip
echo "EFI partition:"
fdisk -l /dev/s$disk$efip
echo "Checking partition"
check $?

echo "Disk:"
fdisk -l /dev/s$disk
echo "Which partition are you going to use for the ROOT? (just the number)"
read rootp
echo "ROOT partition:"
fdisk -l /dev/s$disk$rootp
echo "Checking partition"
check $?

echo "Disk:"
fdisk -l /dev/s$disk
echo "Which partition are you going to use for the SWAP? (just the number)"
read swapp
echo "SWAP partition:"
fdisk -l /dev/s$disk$swapp
echo "Checking partition"
if [ $? != 0 ]; then
    echo "No swap for this one"
    swapp = n
fi

echo "The partitions used are going to be:
EFI system partition: /dev/s$disk$efip
Root: /dev/s$disk$rootp"
if [ $swapp != "n" ]; then
    echo "Swap: /dev/s$disk$swapp"
fi

good

echo "Do you wish to format everything?[Y,n]"
read R

if [ $R != "n" -a $R != "N" ]; then
    echo "Formatting..."
    mkfs.fat -F32 /dev/s$disk$efip;
    check $?
    mkfs.btrfs    /dev/s$disk$rootp;
    check $?
fi

if [ $swapp != "n" ]; then
    mkswap    /dev/s$disk$swapp;
    check $?
fi

mount         /dev/s$disk$rootp /mnt
check $?
mkdir         /mnt/efi
mount         /dev/s$disk$efip /mnt/efi
check $?
if [ $swapp != "n" ]; then
    swapon    /dev/s$disk$swapp
    check $?
fi

pacstrap /mnt base linux linux-firmware linux-headers man-db man-pages texinfo
check $?
cd /mnt
git clone https://github.com/davidxchel/Archinstall
chmod +x /mnt/Archinstall/Configure.sh
cd /
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
echo "Check if there is a problem here, if not, proceed using arch-chroot /mnt
Then use /Archinstall/configure.sh to configure my minimal arch install"
echo "Program finished, Bye!"
