#!/usr/bin/env bash

BINDIR="$HOME/bin"

mkdir -pv "$BINDIR"

currentPath="${0%/*}"

SCRIPT_FILES=(
    "archpwd.sh"
    "publicip.sh"
    "switch_sound.sh"
    "concat_img.sh"
    "../common/save_github.py"
    "weather.sh"
    "getwallpaper.sh"
    "../common/printerrno.pl"
    "show_all_colors_zsh.zsh"
)

# Copy the scripts files to the bin folder.
for file in "${SCRIPT_FILES[@]}"; do
    name="${file##*/}"
    cp -vi "$currentPath/$file" "$BINDIR/${name%.*}"
done
