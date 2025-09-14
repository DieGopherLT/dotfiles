#!/bin/bash

set -e

# Check if git is installed
command -v git >/dev/null 2>&1 || { echo "Git requerido"; exit 1; }

# Install fish shell
sudo dnf install -y fish lsd

# Install fisher (fish plugin manager)
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Install nvm.fish via fisher
fish -c "fisher install jorgebucaran/nvm.fish"

# Set fish as default shell
chsh -s /usr/bin/fish

echo "✅ Fish setup completed"
echo "🔄 To apply changes, run:"
echo "   exec fish"
echo "   (or restart your shell)"

# Prompt for fish change
read -p "Switch to fish? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec fish
fi