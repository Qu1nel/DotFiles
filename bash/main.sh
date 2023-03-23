#!/bin/bash

##   ===========================================================================
##
##   Source mains files
##
##   ===========================================================================

#   Set paths
#   ---------------------------------------------------------------------------

    # If "paths" is exists, include the paths located in the 'paths.sh' file.
    if [ -f "$HOME/.config/bash_config/paths.sh" ]; then
        source "$HOME/.config/bash_config/paths.sh"
    fi

#   Set aliases
#   ---------------------------------------------------------------------------

    # If "aliases" is exists, include the paths located in the 'aliases.sh' file.
    if [ -f "$HOME/.config/bash_config/aliases.sh" ]; then
        source "$HOME/.config/bash_config/aliases.sh"
    fi

#   Define function
#   ---------------------------------------------------------------------------

    # If "functions" is exists, include the paths located in the 'functions.sh' file.
    if [ -f "$HOME/.config/bash_config/functions.sh" ]; then
        source "$HOME/.config/bash_config/functions.sh"
    fi

#   Choice bash prompt
#   ---------------------------------------------------------------------------

    # If "prompt" is exists, include the paths located in the 'prompt.sh' file.
    if [ -f "$HOME/.config/bash_config/prompt.sh" ]; then
        source "$HOME/.config/bash_config/prompt.sh"
    fi

#   Enable welcome tools
#   ---------------------------------------------------------------------------

    neofetch

