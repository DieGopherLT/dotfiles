# Dotfiles

Personal development configurations for Fedora Linux.

## Installation

```bash
git clone https://github.com/DieGopherLT/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Available modules

- **config** - Application configurations (flameshot, starship)
- **fish** - Fish shell with custom aliases and functions
- **git** - Global Git configuration  
- **shell** - Zsh configuration with Oh My Zsh

## Setup

### Using GNU Stow
```bash
stow config git shell  # desired modules
```

### Installation scripts
```bash
./setup_shell.sh  # Setup Zsh + tools
./setup_fish.sh   # Install fish + plugins
```

## Included tools

- **Shell**: Zsh/Fish with Starship prompt
- **Node.js**: NVM, pnpm, bun
- **Git**: Custom aliases and configuration
- **Development**: Android SDK, Go, VS Code integration
- **Terminal**: FZF, lsd, flameshot