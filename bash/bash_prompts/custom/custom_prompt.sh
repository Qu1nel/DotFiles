#!/bin/bash

GIT_PS1_SHOWDIRTYSTATE='y'
GIT_PS1_SHOWUPSTREAM="auto"

function color_my_prompt {
	local purple="\[\033[35m\]"
	local yellow="\[\033[93m\]"
	local green="\[\033[1;32m\]"
	local blue="\[\033[1;34m\]"
	local __end_color="\[\033[00m\]"

	local __my_promt='~$'

	local __time="$yellow [\T]"
	local __user_and_host="$green\u@\h"
	local __cur_location="$blue\w"
	local __git_branch="\$(__git_ps1 [%s])"
	local __git="$yellow$__git_branch"
	local __prompt_tail="$purple$__my_promt"

	export PS1="$__user_and_host$__end_color: $__cur_location $__git\n$__prompt_tail$__end_color "
}

# Enable my prompt
color_my_prompt
unset color_my_prompt
