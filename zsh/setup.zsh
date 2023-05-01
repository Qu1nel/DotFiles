#!/bin/zsh

##  ============================================================================
##
##  Configuration
##
##  ============================================================================

# The name of the folder that will be located in .config
ZSH_CONFIG_FOLDER="zsh_config"

export ZSH_CONFIG_ROOT="$HOME/.config/$ZSH_CONFIG_FOLDER"
ZSHRC_PATH="$HOME/.zshrc"

##  ============================================================================

mkdir -p "$ZSH_CONFIG_ROOT"

normalPath="$(dirname "$0")"

CONFIG_CONTENT=(
    "paths.zsh"
    "aliases.zsh"
    "functions.zsh"
    "main.zsh"
)

# Copy the configuration files to the config folder.
for file in ${CONFIG_CONTENT[@]}; do
    cp -v "$normalPath/$file" "$ZSH_CONFIG_ROOT"
done

# TODO:
# echo 'export ZSH_CONFIG_ROOT="$HOME/.config/zsh_config"' >> "$ZSHRC_PATH"
# echo 'if [ -f "$ZSH_CONFIG_ROOT/main.zsh" ]; then' >> "$ZSHRC_PATH"
# echo '    source "$ZSH_CONFIG_ROOT/main.zsh"' >> "$ZSHRC_PATH"
# echo 'fi' >> "$ZSHRC_PATH"
