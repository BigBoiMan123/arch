#!/bin/bash
parted --script /dev/vda \
mklabel gpt \
mkpart efi 1MiB 512MiB \
mkpart primary 513MiB 9000MiB
mkfs.fat32 /dev/vda1
mkfs.ext4 /dev/vda2
mount /dev/vda2 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot
pacstrap -K /mnt base linux
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
echo "2997" | passwd --stdin root
locale-gen
sed '1i en_US.UTF-8 UTF-8' /etc/locale.gen
sed '1i LANG=en_US.UTF-8' /etc/locale.conf
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
exit
reboot

