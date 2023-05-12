#!/usr/bin/env bash

##  ============================================================================
##
##  Configuration
##
##  ============================================================================

# The name of the folder that will be located in .config
BASH_CONFIG_FOLDER="bash_config"
MARK_HEADER="Bash configuration by Qu1nel"

BASH_CONFIG_ROOT="$HOME/.config/$BASH_CONFIG_FOLDER"e
BASHRC_PATH="$HOME/.bashrc"

##  ============================================================================

mkdir -vp "$BASH_CONFIG_ROOT"

currentPath="${0%/*}"

if [ ! -f "$BASHRC_PATH" ]; then
    cp -v "/etc/skel/.bashrc" "$BASHRC_PATH" # If .bashrc is not in the home directory, make it.
fi

cp -iv "$currentPath/.bashrc" "$BASHRC_PATH"

CONFIG_CONTENT=(
    "paths.sh"
    "aliases.sh"
    "functions.sh"
    "prompt.sh"
    "main.sh"
    "bash_prompts/"
)

# Copy the configuration files to the config folder.
for file in "${CONFIG_CONTENT[@]}"; do
    cp -rv "$currentPath/$file" "$BASH_CONFIG_ROOT"
done

# DATA is the code that will be in '.bashrc'.
DATA=(
    ""
    "##  $MARK_HEADER"
    "##  ============================================================================"
    "export BASH_CONFIG_ROOT=\"$BASH_CONFIG_ROOT\""
    "if [ -f \"\$BASH_CONFIG_ROOT/main.sh\" ] && [ -n \"\$( echo \$- | grep i )\" ]; then"
    "    source \"\$BASH_CONFIG_ROOT/main.sh\""
    "fi"
)

# Writing the configuration startup to a file '.bashrc'.
for idx_code in "${!DATA[@]}"; do
    echo "${DATA[$idx_code]}" >>"$BASHRC_PATH"
done
