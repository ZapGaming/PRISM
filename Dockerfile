FROM debian:bookworm-slim

# Install build tools
RUN apt-get update && apt-get install -y \
    live-build debootstrap \
    xorriso isolinux syslinux-efi \
    grub-pc-bin grub-efi-amd64-bin \
    debian-archive-keyring \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY live-build-config/ .

CMD ["./BUILD.sh"]
