#!/usr/bin/env bash

##  ===========================================================================
##
##  Functions
##
##  ===========================================================================

#   mcd: Makes new Dir and jumps inside.
#   ----------------------------------------------------
mcd() {
    mkdir -pv "$1" && cd "$1" || exit 1
}

#   ftext: Searhes for text in all files in the current folder.
#   ----------------------------------------------------
ftext() {
    # -i case-insensitive
    # -i ignore binary files
    # -h causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -f treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    grep -IiHrn --color=always "$1" . | less -r
}

#   find_largest_files: Find the largest files in a directory.
#   ----------------------------------------------------
find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20
}

#   hg: history and grep <command>
#   ----------------------------------------------------
hg() {
    history | grep "$1"
}
