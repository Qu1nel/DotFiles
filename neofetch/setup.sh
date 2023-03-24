#!/bin/bash

USE_CONFIG="BEJKON2"  # 'PAPIRUS', 'CONFIG', 'ACENOSTER', 'BEJKON2'

normalPath=$(dirname $0)

case $USE_CONFIG in
    "CONFIG")
        cp -iv "$normalPath/config.conf" "$HOME/.config/neofetch/config.conf"
    ;;
    "PAPIRUS")
        cp -iv "$normalPath/papirus.conf" "$HOME/.config/neofetch/config.conf"
    ;;
    "ACENOSTER")
        cp -iv "$normalPath/acenoster.conf" "$HOME/.config/neofetch/config.conf"
    ;;
    "BEJKON2")
        cp -iv "$normalPath/bejkon2/config.conf" "$HOME/.config/neofetch/"
        cp -iv "$normalPath/bejkon2/logo" "$HOME/.config/neofetch/"
    ;;
esac
