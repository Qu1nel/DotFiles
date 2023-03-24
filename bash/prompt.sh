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
        # git clone https://github.com/b-ryan/powerline-shell
        # cd powerline-shell
        # sudo python3 setup.py install 

        function _update_ps1() {
            PS1=$(powerline-shell $?)
        }

        if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
            PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
        fi
    ;;
    *)
        source "$BASH_CONFIG_ROOT/bash_prompts/default/default_prompt.sh"
    ;;
esac

