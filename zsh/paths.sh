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

# GPG keys
export GPG_TTY="$TTY"
gpgconf --launch gpg-agent

# Make git enviroment.
export GIT_CONFIG_GLOBAL="$HOME/.config/git/.gitconfig"

# To configure rust
if [ -d "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# To configure go
if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi

# To configure ssh-agent
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

#   Command history
#   ---------------------------------------------------------------------------

export HISTFILE="$ZDOTDIR/.zshhistoryfile"
export HISTSIZE=5000
export SAVEHIST=5000

setopt appendhistory
