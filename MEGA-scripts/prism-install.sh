#!/bin/bash
# 🌈 PRISM OS INSTALLER - FULL

set -e

echo "🌈 Starting PRISM OS Installation..."

# Mount points
MOUNT=/mnt/prism
EFIMNT=/mnt/prism/efi
BOOTMNT=/mnt/prism/boot

# Get largest unmounted disk
disk=$(lsblk -d -o NAME,SIZE,TYPE | awk '$3=="disk" {print $1,$2}' | sort -k2 -h | tail -1 | cut -d' ' -f1)
[[ -z "$disk" ]] && disk="nvme0n1"

DISK="/dev/$disk"

echo "Target disk: $DISK"

# Partition
echo "Creating partitions..."
parted -s "$DISK" mklabel gpt
parted -s "$DISK" mkpart ESP fat32 1MiB 513MiB
parted -s "$DISK" set 1 esp on
parted -s "$DISK" mkpart PRISM ext4 513MiB 100%

# Format
mkfs.fat -F32 "${DISK}p1" || mkfs.fat -F32 "${DISK}1"
mke2fs -t ext4 -L PRISM "${DISK}p2" || mke2fs -t ext4 -L PRISM "${DISK}2"

# Mount
mkdir -p "$MOUNT"
mount "${DISK}p2" "$MOUNT" || mount "${DISK}2" "$MOUNT"
mkdir -p "$EFIMNT"
mount "${DISK}p1" "$EFIMNT" || mount "${DISK}1" "$EFIMNT"

# Extract squash
unsquashfs \


 -f /live/filesystem.squashfs "$MOUNT"

# Chroot for grub
arch-chroot "$MOUNT" << 'CHROOT'
pacman -S grub efibootmgr --noconfirm
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=PRISM
grub-mkconfig -o /boot/grub/grub.cfg
CHROOT

umount -R "$MOUNT"
echo "✅ PRISM OS Installed!"
