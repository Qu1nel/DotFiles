#!/bin/bash

##  ===========================================================================
##
##   Choise prompt for bash
##
##  ===========================================================================

SELECTED_PROMT="STARSHIP"  # Can be: CUSTOM, SYNTH, STARSHIP, POWERLINE

case "$SELECTED_PROMT" in
    "CUSTOM")
        source "$BASH_CONFIG_ROOT/bash_prompts/custom/custom_prompt.sh"
    ;;
    "SYNTH")
        source "$BASH_CONFIG_ROOT/bash_prompts/synth/synth_prompt.sh"
    ;;
    "STARSHIP")
        source "$BASH_CONFIG_ROOT/bash_prompts/starship/starship_prompt.sh"
    ;;
    "POWERLINE")
        source "$BASH_CONFIG_ROOT/bash_prompts/powerline/powerline.sh"
    ;;
    *)
        source "$BASH_CONFIG_ROOT/bash_prompts/default/default_prompt.sh"
    ;;
esac

