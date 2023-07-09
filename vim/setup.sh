#!/usr/bin/env bash

currentPath="${0%/*}"
cp -vi "$currentPath/.vimrc" "$HOME/"
