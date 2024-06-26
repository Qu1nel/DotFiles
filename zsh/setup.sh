#!/usr/bin/env bash

##  ============================================================================
##
##  Configuration
##
##  ============================================================================

# The name of the folder that will be located in .config
ZDOTDIR="$HOME/.config/zsh"
ZSHRC_PATH="$ZDOTDIR/.zshrc"

##  ============================================================================

mkdir -pv "$ZDOTDIR"

currentPath="${0%/*}"

cp -iv "$currentPath/.zshrc" "$ZSHRC_PATH"
cp -iv "$currentPath/.zshenv" "$HOME"

CONFIG_CONTENT=(
    ".p10k.zsh"
    "paths.sh"
    "aliases.sh"
    "functions.sh"
    "main.sh"
)

# Copy the configuration files to the config folder.
for file in "${CONFIG_CONTENT[@]}"; do
    cp -vi "$currentPath/$file" "$ZDOTDIR/"
done

echo 'if [ -f "$ZDOTDIR/main.sh" ]; then' >> "$ZSHRC_PATH"
echo '    source "$ZDOTDIR/main.sh"' >> "$ZSHRC_PATH"
echo 'fi' >> "$ZSHRC_PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

source "./setup_oh_my_zsh.sh"
