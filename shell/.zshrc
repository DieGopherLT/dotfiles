# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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

# Android SDK configuration
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# NVM configuration (loaded via 'nvm' plugin for lazy loading)
export NVM_DIR="$HOME/.nvm"

# Setting VSCode as default editor in some flows
export EDITOR='code --wait'

# Load local environment variables (not committed to git)
if [[ -f ~/.env.local ]]; then
  source ~/.env.local
fi

# =============================================================================
# CUSTOM FUNCTIONS AND ALIASES
# =============================================================================

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.zsh_functions/aliases.sh
source ~/.zsh_functions/git_helpers.sh

# =============================================================================
# KEY BINDINGS
# =============================================================================
# Custom key bindings for better workflow
bindkey '^ I' complete-word        # tab          | complete
bindkey '^ [[Z' autosuggest-accept # shift + tab  | autosuggest

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# =============================================================================
# STARSHIP THEME CONFIGURATION
# =============================================================================
eval "$(starship init zsh)"

# =============================================================================
# FZF CONFIGURATION
# =============================================================================
source <(fzf --zsh)
