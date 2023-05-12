#!/usr/bin/env bash

##   ===========================================================================
##
##   Source mains files
##
##   ===========================================================================

#   Set paths
#   ---------------------------------------------------------------------------

if [ -f "$ZSH_CONFIG_ROOT/paths.zsh" ]; then
    source "$ZSH_CONFIG_ROOT/paths.zsh"
fi

#   Set aliases
#   ---------------------------------------------------------------------------

if [ -f "$ZSH_CONFIG_ROOT/aliases.zsh" ]; then
    source "$ZSH_CONFIG_ROOT/aliases.zsh"
fi

#   Define function
#   ---------------------------------------------------------------------------

if [ -f "$ZSH_CONFIG_ROOT/functions.zsh" ]; then
    source "$ZSH_CONFIG_ROOT/functions.zsh"
fi

#   Enable welcome tools
#   ---------------------------------------------------------------------------

neofetch
