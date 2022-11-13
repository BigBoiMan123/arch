#!/bin/bash
echo "2997" | passwd --stdin root
locale-gen
sed '1i en_US.UTF-8 UTF-8' /etc/locale.gen
sed '1i LANG=en_US.UTF-8' /etc/locale.conf
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
exit
