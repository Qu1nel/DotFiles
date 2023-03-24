#!/bin/bash

##  ===========================================================================
##
##   Choise prompt for bash
##
##  ===========================================================================

SELECTED_PROMT="SYNTH"  # Can be: CUSTOM, SYNTH

case "$SELECTED_PROMT" in
    "CUSTOM")
        source "$BASH_CONFIG_ROOT/bash_prompts/custom/custom_prompt.sh"
    ;;
    "SYNTH")
        source "$BASH_CONFIG_ROOT/bash_prompts/synth/synth_prompt.sh"
    ;;
    *)
        source "$BASH_CONFIG_ROOT/bash_prompts/default/default_prompt.sh"
    ;;
esac

