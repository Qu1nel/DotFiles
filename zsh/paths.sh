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

#   Paths
#   ---------------------------------------------------------------------------

# Make git enviroment.
export GIT_CONFIG_GLOBAL="$HOME/.config/git/.gitconfig"

# To configure rust
source "$HOME/.cargo/env"

#   Command history
#   ---------------------------------------------------------------------------

export HISTFILE="$ZDOTDIR/.zshhistoryfile"
export HISTSIZE=5000
export SAVEHIST=5000

setopt appendhistory

