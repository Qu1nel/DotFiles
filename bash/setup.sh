#!/bin/bash

##  ============================================================================
##
##  Configuration
##
##  ============================================================================

# The name of the folder that will be located in .config
BASH_CONFIG_FOLDER="bash_config"
MARK_HEADER="Bash configuration by Qu1nel"

BASH_CONFIG_ROOT="$HOME/.config/$BASH_CONFIG_FOLDER"
BASHRC_PATH="$HOME/.bashrc"

##  ============================================================================

mkdir -p "$BASH_CONFIG_ROOT"

normalPath="$(dirname "$0")"

if [ ! -f "$BASHRC_PATH" ]; then
    cp "/etc/skel/.bashrc" "$BASHRC_PATH" # If .bashrc is not in the home directory, make it.
fi

cp -iv "$normalPath/.bashrc" "$BASHRC_PATH"

CONFIG_CONTENT=(
    "paths.sh"
    "aliases.sh"
    "functions.sh"
    "prompt.sh"
    "main.sh"
    "bash_prompts/"
)

# Copy the configuration files to the config folder.
for file in ${CONFIG_CONTENT[@]}; do
    cp -rv "$normalPath/$file" "$BASH_CONFIG_ROOT"
done

# DATA is the code that will be in '.bashrc'.
DATA=(
    ""
    "##  $MARK_HEADER"
    "##  ============================================================================"
    "export BASH_CONFIG_ROOT=\"$BASH_CONFIG_ROOT\""
    'if [ -f "$BASH_CONFIG_ROOT/main.sh" ] && [ -n "$( echo $- | grep i )" ]; then'
    '    source "$BASH_CONFIG_ROOT/main.sh"'
    'fi'
)

lenthData="${#DATA[@]}"

# Writing the configuration startup to a file '.bashrc'.
for idx_code in ${!DATA[@]}; do
    echo "${DATA[$idx_code]}" >> "$BASHRC_PATH"
done

