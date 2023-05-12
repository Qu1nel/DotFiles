#!/usr/bin/env bash

currentPath="${0%/*}"

if [ -z "$BAT_CONFIG_PATH" ]; then
    mkdir -p "$HOME/.config/bat"
    copyPath="$HOME/.config/bat"
else
    copyPath="$BAT_CONFIG_PATH"
fi

cp "$currentPath/config" "$copyPath"
