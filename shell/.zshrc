# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"



# =============================================================================
# PLUGINS CONFIGURATION
# =============================================================================
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Define plugins BEFORE loading Oh My Zsh
plugins=(
  git               # Git integration and aliases
  sudo              # ESC twice to add sudo to previous command
  command-not-found # Suggests packages when command not found
  docker            # Docker completion and aliases
  docker-compose    # Docker Compose completion and aliases
  npm               # NPM completion and aliases
  nvm               # Node Version Manager integration
  golang            # Go language support
)

# =============================================================================
# LOAD OH MY ZSH
# =============================================================================
# Load Oh My Zsh framework (this must come AFTER plugins definition)
source $ZSH/oh-my-zsh.sh

# =============================================================================
# EXTERNAL PLUGINS (if not using Oh My Zsh versions)
# =============================================================================
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =============================================================================
# USER CONFIGURATION
# =============================================================================

# =============================================================================
# TERMINAL APPEARANCE
# =============================================================================
# Set terminal opacity for Ptyxis terminal
PROFILE=$(gsettings get org.gnome.Ptyxis default-profile-uuid)
gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/${PROFILE:1:-1}/ opacity 0.9

# =============================================================================
# PATH CONFIGURATION
# =============================================================================
# Add custom bin directory to PATH
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH=$PATH:/usr/local/go/bin

# Android SDK configuration
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Node.js package managers
# pnpm
export PNPM_HOME="/home/diegopher/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NVM configuration (loaded via 'nvm' plugin for lazy loading)
export NVM_DIR="$HOME/.nvm"

# Setting VSCode as default editor in some flows
export EDITOR='code --wait'

# Claude Code settings
export DISABLE_AUTOUPDATER=1

# Load local environment variables (not committed to git)
if [[ -f ~/.env.local ]]; then
  source ~/.env.local
fi

# =============================================================================
# CUSTOM FUNCTIONS AND ALIASES
# =============================================================================

source ~/.zsh_functions/aliases.sh
source ~/.zsh_functions/git_helpers.sh

# =============================================================================
# KEY BINDINGS
# =============================================================================
# Custom key bindings for better workflow
bindkey '^ I' complete-word        # tab          | complete
bindkey '^ [[Z' autosuggest-accept # shift + tab  | autosuggest


# =============================================================================
# EXTERNAL TOOLS CONFIGURATION
# =============================================================================
# Starship prompt
eval "$(starship init zsh)"

# FZF fuzzy finder
source <(fzf --zsh)

# Bun completions
[ -s "/home/diegopher/.bun/_bun" ] && source "/home/diegopher/.bun/_bun"