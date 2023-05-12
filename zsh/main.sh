#!/usr/bin/env bash

##   ===========================================================================
##
##   Source mains files
##
##   ===========================================================================

#   Set paths
#   ---------------------------------------------------------------------------

if [ -f "$ZSH_CONFIG_ROOT/paths.sh" ]; then
    source "$ZSH_CONFIG_ROOT/paths.sh"
fi

#   Set aliases
#   ---------------------------------------------------------------------------

if [ -f "$ZSH_CONFIG_ROOT/aliases.sh" ]; then
    source "$ZSH_CONFIG_ROOT/aliases.sh"
fi

#   Define function
#   ---------------------------------------------------------------------------

if [ -f "$ZSH_CONFIG_ROOT/functions.sh" ]; then
    source "$ZSH_CONFIG_ROOT/functions.sh"
fi

neofetch
