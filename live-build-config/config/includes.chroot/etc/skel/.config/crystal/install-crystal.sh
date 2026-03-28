#!/bin/bash
# Crystal Linux Automated Installer
set -e

echo "🔮 Installing Crystal Linux..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Run with sudo"
    exit 1
fi

# Get install target
read -p "Target drive (e.g., /dev/nvme0n1): " TARGET
read -p "Hostname: " HOSTNAME
read -p "Username: " USERNAME
read -sp "Password: " PASSWORD
echo

# Partition
sfdisk "$TARGET" <<EOF
label: gpt
size=512M, type=uefi, bootable
EOF

PART="${TARGET}p"
mkfs.fat -F32 "${PART}1"
mkfs.ext4 "${PART}2"

# Mount
mount "${PART}2" /mnt
mkdir /mnt/boot
mount "${PART}1" /mnt/boot

# Install base
pacstrap /mnt base base-devel linux linux-firmware networkmanager vim

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot configuration
arch-chroot /mnt <<CHROOT
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts <<EOF
127.0.0.1    localhost
::1          localhost
127.0.1.1    $HOSTNAME
EOF

# Enable services
systemctl enable NetworkManager
systemctl enable systemd-timesyncd

# Install Crystal packages
pacman -S --noconfirm xorg-server xorg-xinit i3-gaps polybar rofi kitty picom dunst feh thunar

# Create user
useradd -m -G wheel,audio,video,optical,storage -s /bin/zsh "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd
echo "root:$PASSWORD" | chpasswd

# Add to sudoers
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
CHROOT

# Copy Crystal configs
mkdir -p /mnt/home/$USERNAME/.config/crystal
sudo -u "$USERNAME" cp -r /mnt/etc/skel/.config/* /mnt/home/$USERNAME/.config/
sudo -u "$USERNAME" cp /mnt/usr/share/backgrounds/crystal/wallpaper.png /mnt/home/$USERNAME/.config/crystal/

# Install bootloader
arch-chroot /mnt <<CHROOT
bootctl install
cat > /boot/loader/loader.conf <<EOF
timeout 3
console-mode max
EOF

cat > /boot/loader/entries/crystal.conf <<EOF
title Crystal Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=UUID=$(blkid -s UUID -o value "${PART}2") rw
EOF
CHROOT

echo "✨ Crystal Linux installed! Reboot to enter the crystal realm."