if status is-interactive
    # Commands to run in interactive sessions can go here

    # =============================================================================
    # TERMINAL APPEARANCE
    # =============================================================================
    set PROFILE (gsettings get org.gnome.Ptyxis default-profile-uuid)
    set CLEAN_PROFILE (string replace -r "^'|'\$" "" $PROFILE)
    gsettings set "org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$CLEAN_PROFILE/" opacity 0.9

    # =============================================================================
    # PATH CONFIGURATION
    # =============================================================================
    # Add custom bin directory to PATH
    fish_add_path "$HOME/.bin"
    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/go/bin"
    fish_add_path "/usr/local/go/bin"

    # Android SDK configuration
    set -x ANDROID_HOME "$HOME/Android/Sdk"
    fish_add_path "$ANDROID_HOME/emulator"
    fish_add_path "$ANDROID_HOME/platform-tools"

    # NVM configuration
    set -x NVM_DIR "$HOME/.nvm"

    # Setting VSCode as default editor in some flows
    set -x EDITOR 'code --wait'

    # Claude Code settings
    set -x DISABLE_AUTOUPDATER 1

    if test -f ~/.env.local
        source ~/.env.local
    end

    # SSH
    if not pgrep -u (id -u) ssh-agent > /dev/null
        eval (ssh-agent -c)
    end
    ssh-add -q ~/.ssh/*

    # =============================================================================
    # CUSTOM FUNCTIONS AND ALIASES
    # =============================================================================
    # Source Zsh functions and aliases using bass
    source ~/.config/fish/functions/aliases.fish
    source ~/.config/fish/functions/git_helpers.fish

    # =============================================================================
    # NODE.JS RELATED
    # =============================================================================

    # pnpm
    set -x PNPM_HOME "/home/diegopher/.local/share/pnpm"
    fish_add_path $PNPM_HOME
    # pnpm end

    # bun completions
    [ -s "/home/diegopher/.bun/_bun/" ] && source "/home/diegopher/.bun/_bun/"

    # bun
    set -x BUN_INSTALL "$HOME/.bun"
    fish_add_path "$BUN_INSTALL/bin"

    # Starship 
    if command -v starship > /dev/null
        starship init fish | source
    end
end
