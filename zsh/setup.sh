#!/usr/bin/env bash

##  ============================================================================
##
##  Configuration
##
##  ============================================================================

# The name of the folder that will be located in .config
ZSHRC_PATH="$HOME/.zshrc"
ZSH_CONFIG_FOLDER="zsh_config"

export ZSH_CONFIG_ROOT="$HOME/.config/$ZSH_CONFIG_FOLDER"

##  ============================================================================

mkdir -pv "$ZSH_CONFIG_ROOT"

currentPath="${0%/*}"

cp -iv "$currentPath/.zshrc" "$ZSHRC_PATH"

CONFIG_CONTENT=(
    "paths.sh"
    "aliases.sh"
    "functions.sh"
    "main.sh"
)

# Copy the configuration files to the config folder.
for file in "${CONFIG_CONTENT[@]}"; do
    cp -vi "$currentPath/$file" "$ZSH_CONFIG_ROOT"
done

echo 'export ZSH_CONFIG_ROOT="$HOME/.config/'"$ZSH_CONFIG_FOLDER"'"' >> "$ZSHRC_PATH"
echo 'if [ -f "$ZSH_CONFIG_ROOT/main.zsh" ]; then' >> "$ZSHRC_PATH"
echo '    source "$ZSH_CONFIG_ROOT/main.zsh"' >> "$ZSHRC_PATH"
echo 'fi' >> "$ZSHRC_PATH"
