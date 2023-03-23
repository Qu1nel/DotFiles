#!/bin/bash

##  ===========================================================================
##
##   Choise prompt for bash
##
##  ===========================================================================

SELECTED_PROMT="SYNTH"  # Can be: CUSTOM, SYNTH

case "$SELECTED_PROMT" in
    "CUSTOM")
        source "$HOME/.config/bash_config/bash_prompts/custom/custom_prompt.sh"
    ;;
    "SYNTH")
        source "$HOME/.config/bash_config/bash_prompts/synth/synth_prompt.sh"
    ;;
    *)
        source "$HOME/.config/bash_config/bash_prompts/default/default_prompt.sh"
    ;;
esac

