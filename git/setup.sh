#!/usr/bin/env bash

echo "Enter information about you for git."
read -rp "Your name: " enterName
read -rp "Your email: " enterEmail
read -rp "Your nickname: " enterNick

export NAME="$enterName"
export EMAIL="$enterEmail"
export NICKNAME="$enterNick"

echo

currentPath="${0%/*}"

if ! command python3 "$currentPath/src/InitConfig.py"; then
    exit 1
fi

if [ -v "$GIT_CONFIG_GLOBAL" ]; then
    cp -vi "$currentPath/commit_template_message" "$HOME"

    GIT_CONFIG_PATH="$HOME"
else
    configDir="${GIT_CONFIG_GLOBAL%/*}"
    mkdir -pv "$configDir"

    cp -vi "$currentPath/commit_template_message" "$configDir"

    GIT_CONFIG_PATH="$GIT_CONFIG_GLOBAL"

    rm -fv "$HOME/.gitconfig"
    rm -fv "$HOME/commit_template_message"
fi

echo

cp -vi "$currentPath/.gitconfig" "$GIT_CONFIG_PATH"
