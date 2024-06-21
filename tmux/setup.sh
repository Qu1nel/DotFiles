#!/usr/bin/env bash

currentPath="${0%/*}"
file=".tmux.conf"

cp -vi "$currentPath/$file" "$HOME/"
