#!/bin/bash
echo 'Partitioning Disk...'
parted --script /dev/vda \
rm 1 \
rm 2 \
mklabel gpt \
mkpart efi 1MiB 512MiB \
mkpart primary 513MiB 9000MiB
echo 'Formatting Disk...'
mkfs.vfat -F 32 /dev/vda1
mkfs.ext4 /dev/vda2
echo 'Mounting Disk...'
mount /dev/vda2 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot
echo 'Preparing Scripts...'
cp -r /root/archspeedrun /mnt/archspeedrun
echo 'Installing Base System...'
pacstrap -K /mnt base linux
echo 'Generating Filesystem Table...'
genfstab -U /mnt >> /mnt/etc/fstab
echo 'Chrooting into the new system...'
{
cat /mnt/archspeedrun/chroot.sh
} | arch-chroot /mnt
exit
