#!/bin/bash

##   ===========================================================================
##
##   Source mains files
##
##   ===========================================================================

#   Set paths
#   ---------------------------------------------------------------------------

    # If "paths" is exists, include the paths located in the 'paths.sh' file.
    if [ -f "$BASH_CONFIG_ROOT/paths.sh" ]; then
        source "$BASH_CONFIG_ROOT/paths.sh"
    fi

#   Set aliases
#   ---------------------------------------------------------------------------

    # If "aliases" is exists, include the paths located in the 'aliases.sh' file.
    if [ -f "$BASH_CONFIG_ROOT/aliases.sh" ]; then
        source "$BASH_CONFIG_ROOT/aliases.sh"
    fi

#   Define function
#   ---------------------------------------------------------------------------

    # If "functions" is exists, include the paths located in the 'functions.sh' file.
    if [ -f "$BASH_CONFIG_ROOT/functions.sh" ]; then
        source "$BASH_CONFIG_ROOT/functions.sh"
    fi

#   Choice bash prompt
#   ---------------------------------------------------------------------------

    # If "prompt" is exists, include the paths located in the 'prompt.sh' file.
    if [ -f "$BASH_CONFIG_ROOT/prompt.sh" ]; then
        source "$BASH_CONFIG_ROOT/prompt.sh"
    fi

#   Enable welcome tools
#   ---------------------------------------------------------------------------

    neofetch

