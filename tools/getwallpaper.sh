#!/usr/bin/env bash

url_img="$(wget -O - https://www.reddit.com/r/wallpaper/ |\
    grep -oP 'https?:\/\/preview\.redd\.it\/[^"\/]+(?=\?)' | sed 's/preview/i/gm' |\
    sort | uniq | sort | uniq | sort |\
    shuf -n 1)"

extension=${url_img: -3}
wallpaper="background.$extension"

wget -O "/tmp/$wallpaper" "$url_img"
gsettings set org.gnome.desktop.background picture-uri "/tmp/$wallpaper"
