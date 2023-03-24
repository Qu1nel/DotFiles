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

# TODO -----------------------------------------------------------* TODO
cwd=$(dirname "$0")

cp "$cwd/paths.sh" "$HOME/.config/bash_config"
cp "$cwd/aliases.sh" "$HOME/.config/bash_config"
cp "$cwd/functions.sh" "$HOME/.config/bash_config"
cp "$cwd/prompt.sh" "$HOME/.config/bash_config"
cp -r "$cwd/bash_prompts/" "$HOME/.config/bash_config"
cp "$cwd/main.sh" "$HOME/.config/bash_config"
# TODO -----------------------------------------------------------* TODO


# DATA is the code that will be in .bashrc
DATA=(
    ""
    "##  $MARK_HEADER"
    "##  ============================================================================"
    "export BASH_CONFIG_ROOT=\"$BASH_CONFIG_ROOT\""
    'if [ -f "$BASH_CONFIG_ROOT/main.sh" ] && [ -n "$( echo $- | grep i )" ]; then'
    '    source "$BASH_CONFIG_ROOT/main.sh"'
    'fi'
)

lenthData=${#DATA[@]}
startLineCode=$(($(grep -n "$MARK_HEADER" "$BASHRC_PATH" | sed 's/:.*//g')-1))

if [ $startLineCode ]; then
    for i in $(seq 1 $lenthData); do
        sed -i "${startLineCode}d" "$BASHRC_PATH"
    done
fi

for idx_code in ${!DATA[@]}; do
    echo "${DATA[$idx_code]}" >> "$BASHRC_PATH"
done
