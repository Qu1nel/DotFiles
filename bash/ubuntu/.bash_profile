#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management						# NoImplement
#  4.   Searching								# NoImplement
#  5.   Process Management							# NoImplement
#  6.   Networking								# NoImplement
#  7.   System Operations & Information						# NoImplement
#  8.   Web Development								# NoImplement
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------
GIT_PS1_SHOWDIRTYSTATE='y'
GIT_PS1_SHOWUPSTREAM="auto"

function color_my_prompt {
    local purple="\[\033[35m\]"
    local yellow="\[\033[93m\]"
    local green="\[\033[32m\]"
    local blue="\[\033[34m\]"
    local __end_color="\[\033[00m\]"

    local __my_promt='\$_>'

    local __time="$yellow[\T]"
    local __user_and_host="$green\u@\h"
    local __cur_location="$blue\w"
    local __git_branch='$(__git_ps1 "(%s)")'
    local __git="$yellow$__git_branch"
    local __prompt_tail="$purple$__my_promt"

    export PS1="$__time $__user_and_host$__end_color: $__cur_location$col $__git\n$__prompt_tail$__end_color "
}
color_my_prompt

#   Set Paths
#   ----------------------------------------------------
    export EDITOR="/usr/bin/vim"  # TODO: change to nvim in future 
    
    export BAT_CONFIG_PATH="$HOME/.dotfiles/bat/bat.conf"  # For bat tools


#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

#   Aliases for bash
#   ----------------------------------------------------
    if [ -f "$HOME/.dotfiles/bash/.bash_aliases" ]; then
        source "$HOME/.dotfiles/bash/.bash_aliases"
    else
        # Default aliases
	alias cp='cp -iv'
	alias mv='mv -iv'
	alias mkdir='mkdir -pv'
	alias ~='cd ~'
    fi

#   extract: Extract most know archives with one command
#   ----------------------------------------------------
    extract () {
        if [ -f $1 ]; then
            case $1 in
                *.tar.bz2)	tar xjf $1	;;
		*.tar.gz)	tar xzf $1	;;
		*.bz2)		bunzip2 $1	;;
		*.rar)		unrar e $1	;;
		*.gz)		gunzip $1	;;
		*.tar)		tar xf $1	;;
		*.tbz2)		tar xjf $1	;;
		*.tgz)		tar xzf	$1	;;
		*.zip)		unzip $1	;;
		*.Z)		uncompress $1	;;
		*.7z)		7z x $1		;;
		*)	echo "'$1' cannot be extracted via extract()" ;;
	    esac
        else
	    echo "'$1' is not a valid file"
        fi
    }
