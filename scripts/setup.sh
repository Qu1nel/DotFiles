#!/usr/bin/env bash

BINDIR="$HOME/bin"

mkdir -pv "$BINDIR"

currentPath="${0%/*}"

SCRIPT_FILES=(
    "archpwd.sh"
    "publicip.sh"
    "switch_sound.sh"
    "concat_img.sh"
    "save_github.py"
    "weather.sh"
    "getwallpaper.sh"
    "printerrno.pl"
    "show_all_colors_zsh.zsh"
)

# Copy the scripts files to the bin folder.
for file in "${SCRIPT_FILES[@]}"; do
    cp -vi "$currentPath/$file" "$BINDIR/${file%.*}"
done
