#!/usr/bin/env bash

USE_CONFIG="BEJKON2"  # 'PAPIRUS', 'CONFIG', 'ACENOSTER', 'BEJKON2'

currentPath="${0%/*}"

case "$USE_CONFIG" in
    "CONFIG")
        cp -iv "$currentPath/config.conf" "$HOME/.config/neofetch/config.conf"
        ;;
    "PAPIRUS")
        cp -iv "$currentPath/papirus.conf" "$HOME/.config/neofetch/config.conf"
        ;;
    "ACENOSTER")
        cp -iv "$currentPath/acenoster.conf" "$HOME/.config/neofetch/config.conf"
        ;;
    "BEJKON2")
        cp -iv "$currentPath/bejkon2/config.conf" "$HOME/.config/neofetch/"
        cp -iv "$currentPath/bejkon2/logo" "$HOME/.config/neofetch/"
        ;;
esac
