#! /bin/bash

set -e

# Check if git is installed
command -v git >/dev/null 2>&1 || { echo "Git requerido"; exit 1; }

# Install install necessary packages
sudo dnf install -y zsh zsh-autosuggestions zsh-syntax-highlighting lsd

# Install oh-my-zsh
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p "$HOME"/.config

# Install starship
curl -sS https://starship.rs/install.sh | sh
cp ./config/.config/starship.toml "$HOME"/.config/starship.toml

# Setting up custom aliases and functions
cp -r ./shell/.bin "$HOME"/.bin
chmod +x "$HOME"/.bin/*

cp -r ./shell/.zsh_functions "$HOME"/.zsh_functions
chmod +x "$HOME"/.zsh_functions/*

# Copy ZSH config and set zsh as default shell
cp ./shell/.zshrc "$HOME"/.zshrc
chsh -s /bin/zsh

echo "✅ Completed setup"
echo "🔄 To apply changes, run:"
echo "   exec zsh"
echo "   (or restart your shell)"

# Prompt for zsh change
read -p "Switch to zsh? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec zsh
fi