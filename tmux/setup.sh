#!/usr/bin/env bash

currentPath="${0%/*}"

config_folder=".tmux"

cp -vri "$currentPath/$config_folder" "$HOME"
cp -v "$currentPath/$config_folder/.tmux.conf.local" "$HOME"

ln -s -f "$currentPath/$config_folder/.tmux.conf" "$HOME"

