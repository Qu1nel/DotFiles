#!/bin/bash

##  ===========================================================================
##
##  Aliases
##
##  ===========================================================================

#   General
#   ---------------------------------------------------------------------------

    alias cp='cp -iv'			      # Preferred 'cp' implemention.
    alias mv='mv -iv'			      # Preferred 'mv' implemention.
    alias mkdir='mkdir -pv'			# Preferred 'mkdir' implemention.
    alias ~='cd ~'				      # ~:	Go Home.

#   ls
#   ---------------------------------------------------------------------------

    alias ls='exa -F --icons'		      # Preferred 'ls' implemention.
    alias ll='ls -bghHiSl -T -L 2'		# ll: 'ls' modification for files.
    alias lsd='ls -l -D -T -L 3'		  # lsd: 'ls' modification for folders.

#   Other
#   ---------------------------------------------------------------------------

    alias cat='bat --paging=never'		# cat: 'bat' modification for printing contents.

