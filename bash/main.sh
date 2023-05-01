#!/bin/bash

##   ===========================================================================
##
##   Source mains files
##
##   ===========================================================================

#   Set paths
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/paths.sh" ]; then
    # shellcheck disable=SC1091
    source "$BASH_CONFIG_ROOT/paths.sh"
fi

#   Set aliases
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/aliases.sh" ]; then
    # shellcheck disable=SC1091
    source "$BASH_CONFIG_ROOT/aliases.sh"
fi

#   Define function
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/functions.sh" ]; then
    # shellcheck disable=SC1091
    source "$BASH_CONFIG_ROOT/functions.sh"
fi

#   Choice bash prompt
#   ---------------------------------------------------------------------------

if [ -f "$BASH_CONFIG_ROOT/prompt.sh" ]; then
    # shellcheck disable=SC1091
    source "$BASH_CONFIG_ROOT/prompt.sh"
fi

#   Enable welcome tools
#   ---------------------------------------------------------------------------

neofetch
