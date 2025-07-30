#! /bin/bash

set -e

mkdir -p "$HOME"/.config/rofi
mkdir -p "$HOME"/.local/share/rofi/themes

# Update system
dnf update -y

# Install programming languages
sudo dnf install -y nvm golang dotnet-sdk-9.0
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# Install VS Code

rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf -y install code

# Install Docker
dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker
usermod -aG docker "$USER"

# Install misc dependencies
sudo dnf install -y yarn stow

# A minimal and customizable application launcher 
dnf -y install rofi
mv ./rofi/.config/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
mv ./rofi/.local/share/rofi/themes/spotlight-dark.rasi "$HOME"/.local/share/rofi/themes/spotlight-dark.rasi
echo "To launch rofi, run 'rofi -show drun -show-icons'"

echo "⚠️  Important: Restart the system to use Docker" 
echo "✅ Completed installations"