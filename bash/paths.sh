#!/usr/bin/env bash
##  ===========================================================================
##
##  Paths and variables
##
##  ===========================================================================

#   Vars
#   ---------------------------------------------------------------------------

# Set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=nvim
export GPG_TTY="$TTY"
gpgconf --launch gpg-agent

#   Paths
#   ---------------------------------------------------------------------------

# Make git enviroment.
export GIT_CONFIG_GLOBAL="$HOME/.config/git/.gitconfig"

# Make starship config file location
export STARSHIP_CONFIG="$BASH_CONFIG_ROOT/bash_prompts/starship/settings/starship.toml"

# To configure rust
source "$HOME/.cargo/env"

#   Command history
#   ---------------------------------------------------------------------------
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%Y-%m-%d %T " # For showing time in history bash command.
