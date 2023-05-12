#!/usr/bin/env bash

##  ===========================================================================
##
##   Choise prompt for bash
##
##  ===========================================================================

SELECTED_PROMT="SYNTH" # Can be: CUSTOM, SYNTH, STARSHIP, POWERLINE

case "$SELECTED_PROMT" in
    "CUSTOM")
        # shellcheck disable=SC1091
        source "$BASH_CONFIG_ROOT/bash_prompts/custom/custom_prompt.sh"
        ;;
    "SYNTH")
        # shellcheck disable=SC1091
        source "$BASH_CONFIG_ROOT/bash_prompts/synth/synth_prompt.sh"
        ;;
    "STARSHIP")
        # shellcheck disable=SC1091
        source "$BASH_CONFIG_ROOT/bash_prompts/starship/starship_prompt.sh"
        ;;
    "POWERLINE")
        # shellcheck disable=SC1091
        source "$BASH_CONFIG_ROOT/bash_prompts/powerline/powerline.sh"
        ;;
    *)
        # shellcheck disable=SC1091
        source "$BASH_CONFIG_ROOT/bash_prompts/default/default_prompt.sh"
        ;;
esac
