#!/usr/bin/env bash

##   ===========================================================================
##
##   Source mains files
##
##   ===========================================================================

#   Set paths
#   ---------------------------------------------------------------------------

if [ -f "$ZDOTDIR/paths.sh" ]; then
    source "$ZDOTDIR/paths.sh"
fi

#   Set aliases
#   ---------------------------------------------------------------------------

if [ -f "$ZDOTDIR/aliases.sh" ]; then
    source "$ZDOTDIR/aliases.sh"
fi

#   Define function
#   ---------------------------------------------------------------------------

if [ -f "$ZDOTDIR/functions.sh" ]; then
    source "$ZDOTDIR/functions.sh"
fi
