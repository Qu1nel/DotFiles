#!/usr/bin/env bash

##  ===========================================================================
##
##  Aliases
##
##  ===========================================================================

#   General
#   ---------------------------------------------------------------------------

alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ~='cd ~'
alias sudo='\sudo '
alias rm='/bin/rm --verbose'
alias rmd="/bin/rm --recursive --force --verbose"
alias ping="ping -c 10"
alias da='date "+%Y-%m-%d %A %T %Z"'
alias bashrcconfig="nvim ~/.bashrc"

#   cd
#   ---------------------------------------------------------------------------

alias cd..='cd ..'
alias ..="cd .."
alias ...="cd ../.."
alias ....='cd ../../../'
alias .....="cd ../../../../"

#   ls
#   ---------------------------------------------------------------------------

alias ls='exa --icons'

alias l='exa --classify --icons'
alias la='exa --all --classify --icons'
alias ll='exa -bghiHS --long --group-directories-first'
alias lla='ll --all'

#   Disk space and spase used in a folder
#   ---------------------------------------------------------------------------

alias diskspace="du -S | sort -n -r | more"
alias folders="du -h --max-depth=1"
alias tree="tree -CAhF --dirsfirst"
alias treed="tree -CAFd"
alias mountedinfo="df -hT"

#   Net
#   ---------------------------------------------------------------------------

alias openports="netstat -nape --inet"

#   Other
#   ---------------------------------------------------------------------------

alias cputop="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias checkcommand="type"
alias rebootsafe="sudo shutdown -r now"
alias rebootforce="sudo shutdown -r -n now"
alias cat='bat --paging=never' # cat: 'bat' modification for printing contents.
alias xcopy='xclip -sel clip'
alias xpaste='xclip -sel clip -o'
