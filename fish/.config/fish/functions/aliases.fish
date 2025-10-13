# ~/.config/fish/functions/aliases.fish

# Aliases for common directories and tasks
alias taloon='cd "$HOME/Documents/taloon"'
alias exhio='cd "$HOME/Documents/exhio"'
alias workspaces='cd "$HOME/Documents/taloon/workspaces"'
alias dow='cd "$HOME/Downloads"'
alias docs='cd "$HOME/Documents"'
alias courses='cd "$HOME/Documents/courses"'
alias projects='cd "$HOME/Documents/projects"'
alias tools='cd "$HOME/Documents/tools"'

# Aliases for editing and reloading fish config
alias editrc='code "$HOME/.config/fish/config.fish"'
alias reloadrc='source "$HOME/.config/fish/config.fish"'
alias editscripts='code "$HOME/.config/fish/functions"'

# Git related
alias gstatus='git status'

# General purpose
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -la'

# Claude related
alias editcc='code "$HOME/.claude/CLAUDE.md"'
alias editcconfig='code "$HOME/.claude.json"'