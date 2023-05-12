#!/usr/bin/env bash

# git clone https://github.com/b-ryan/powerline-shell
# cd powerline-shell
# sudo python3 setup.py install

function _update_ps1() {
  PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
