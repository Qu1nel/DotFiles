#!/usr/bin/env bash

##   ===========================================================================
##
##   Source mains files
##
##   ===========================================================================

#   Set paths
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/paths.sh" ]; then
    source "$BASH_CONFIG_ROOT/paths.sh"
fi

#   Set aliases
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/aliases.sh" ]; then
    source "$BASH_CONFIG_ROOT/aliases.sh"
fi

#   Define function
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/functions.sh" ]; then
    source "$BASH_CONFIG_ROOT/functions.sh"
fi

#   Choice bash prompt
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/prompt.sh" ]; then
    source "$BASH_CONFIG_ROOT/prompt.sh"
fi

neofetch
