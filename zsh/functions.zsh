#!/bin/zsh

##  ===========================================================================
##
##  Functions
##
##  ===========================================================================

#   extract: Extract most know archives with one command.
#   ----------------------------------------------------
extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

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
