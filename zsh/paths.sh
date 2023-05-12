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
export GIT_CONFIG_GLOBAL="$HOME/.config/git/gitconfig"

# Make dir for bat configurations and set CONFIG_PATH for bat.
mkdir -p "$HOME/.config/bat"
export BAT_CONFIG_PATH="$HOME/.config/bat/config"

# Init PATH for pyenv root.
export PYENV_ROOT="$HOME/.config/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#   Command history
#   ---------------------------------------------------------------------------

export HISTFILE="$HOME/.cache/zshhistory"
setopt appendhistory
