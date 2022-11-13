#!/bin/bash
touch passwd.txt
sed -i '1i root:root' passwd.txt
chpasswd <passwd.txt
touch /etc/hostname
sed -i '1i archspeedrun' /etc/hostname
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/timezone
locale-gen
sed -i '1i en_US.UTF-8 UTF-8' /etc/locale.gen
touch /etc/locale.conf
sed -i '1i LANG=en_US.UTF-8' /etc/locale.conf
sed -i 's/Required DatabaseOptional/Never/' /etc/pacman.conf
pacman -S grub efibootmgr --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
exit
