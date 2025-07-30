#!/bin/bash

set -e

echo "🎬 Installing multimedia codecs and NVIDIA drivers for Fedora..."

# Check if this is Fedora
if ! command -v dnf >/dev/null 2>&1; then
    echo "❌ This script is only for Fedora"
    exit 1
fi

# Update system
echo "📦 Updating system..."
sudo dnf update -y

# Install RPM Fusion (required for codecs and drivers)
echo "🔧 Installing RPM Fusion..."
FEDORA_VERSION=$(rpm -E %fedora)
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm

# Update after adding RPM Fusion
sudo dnf update -y

# Install multimedia codecs
echo "🎵 Installing multimedia codecs..."
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# Additional codecs
echo "🎥 Installing additional codecs..."
sudo dnf install -y gstreamer1-plugins-{bad-*,good-*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel

# Specific audio/video codecs
sudo dnf install -y \
    ffmpeg \
    ffmpeg-libs \
    libdvdcss \
    x264 \
    x265 \
    lame

# Detect NVIDIA GPU
echo "🖥️  Detecting graphics hardware..."
if lspci | grep -i nvidia >/dev/null; then
    echo "✅ NVIDIA GPU detected"
    
    # Install NVIDIA drivers
    echo "🎮 Installing NVIDIA drivers..."
    sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
    
    # NVIDIA Video Acceleration
    sudo dnf install -y nvidia-vaapi-driver
    
    # NVIDIA tools
    sudo dnf install -y nvidia-settings nvidia-persistenced
    
    echo "⚠️  IMPORTANT: Reboot the system for NVIDIA drivers to take effect"
    echo "   Drivers will compile automatically on first reboot"
else
    echo "ℹ️  No NVIDIA GPU detected, skipping driver installation"
fi

# Additional multimedia tools
echo "🛠️  Installing multimedia tools..."
sudo dnf install -y \
    vlc \
    mpv \
    obs-studio \
    audacity \
    gimp

# Configure Flatpak (for additional applications)
echo "📱 Configuring Flatpak..."
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "✅ Installation completed!"
echo ""
echo "📋 Summary of installed components:"
echo "   • Complete multimedia codecs (H.264, H.265, MP3, etc.)"
echo "   • FFmpeg and conversion tools"
echo "   • VLC, MPV, OBS Studio"
if lspci | grep -i nvidia >/dev/null; then
    echo "   • Proprietary NVIDIA drivers"
    echo "   • NVIDIA VAAPI for video acceleration"
fi
echo "   • Flatpak configured with Flathub"
echo ""
if lspci | grep -i nvidia >/dev/null; then
    echo "🔄 REBOOT REQUIRED to activate NVIDIA drivers"
else
    echo "🎉 All done! No reboot required"
fi