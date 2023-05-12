#!/usr/bin/env bash

echo "Enter information about you for git."
read -rp "Your name: " enterName
read -rp "Your email: " enterEmail
read -rp "Your nickname: " enterNick

export NAME="$enterName"
export EMAIL="$enterEmail"
export NICKNAME="$enterNick"

echo ""

normalPath="$(dirname $0)"

if ! command python3 "$normalPath/src/InitConfig.py"; then
    exit 1
fi

if [ -v "$GIT_CONFIG_GLOBAL" ]; then
    cp -vi "$normalPath/commit_template_message.txt" "$HOME"

    GIT_CONFIG_PATH="$HOME"
else
    configDir=$(dirname "$GIT_CONFIG_GLOBAL")
    mkdir -pv "$configDir"

    cp -vi "$normalPath/commit_template_message.txt" "$configDir"

    GIT_CONFIG_PATH="$GIT_CONFIG_GLOBAL"

    rm -fv "$HOME/.gitconfig"
    rm -fv "$HOME/commit_template_message.txt"
fi

echo ""

cp -vi "$normalPath/.gitconfig" "$GIT_CONFIG_PATH"
