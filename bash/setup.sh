#!/bin/bash

##  ============================================================================
##
##  CONFIGURATION
##
##  ============================================================================

# The name of the folder that will be located in .config
BASH_CONFIG_FOLDER="bash_config"
MARK_HEADER="Bash configuration by Qu1nel"

BASH_CONFIG_ROOT="$HOME/.config/$BASH_CONFIG_FOLDER"

##  ============================================================================

mkdir -p "$BASH_CONFIG_ROOT"

BASHRC_PATH="$HOME/.bashrc"
if [ ! -f "$BASHRC_PATH" ]; then
    cp "/etc/skel/.bashrc" "$BASHRC_PATH" # If .bashrc is not in the home directory, make it.
fi

CONFIG_CONTENT=(
    "paths.sh"
    "aliases.sh"
    "functions.sh"
    "prompt.sh"
    "main.sh"
    "bash_prompts/"
)

normalPath=$(dirname "$0")

# Copy the configuration files to the config folder.
for file in ${CONFIG_CONTENT[@]}; do
    cp -r "$normalPath/$file" "$BASH_CONFIG_ROOT"
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

# Line number start of the configuration start line.
startLineCode=$(($(grep -n "$MARK_HEADER" "$BASHRC_PATH" | sed 's/:.*//g')-1))
lenthData=${#DATA[@]}

# Deleting configuration startup lines from the file '.bashrc'.
if [ $startLineCode ]; then
    for i in $(seq 1 $lenthData); do
        sed -i "${startLineCode}d" "$BASHRC_PATH"
    done
fi

# Writing the configuration startup to a file '.bashrc'.
for idx_code in ${!DATA[@]}; do
    echo "${DATA[$idx_code]}" >> "$BASHRC_PATH"
done

