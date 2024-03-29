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

alias cd..='cd .. && lla'
alias ..="cd .. && lla"
alias ...="cd ../.. && lla"
alias ....='cd ../../../ && lla'
alias .....="cd ../../../../ && lla"
alias de="cd ~/Desktop"

#   ls
#   ---------------------------------------------------------------------------

alias ls='exa --icons --classify --group-directories-first'
alias l='ls'
alias la='ls --all'
alias lat='la -T'
alias ll='ls -bghiHS --long'
alias lla='ll --all'
alias llat='lla -T'

#   git
#   ---------------------------------------------------------------------------

alias ga='git add'
alias gadd='git add'
alias gl='git ls'
alias gitls='git ls'
alias gs='git s'
alias gits='git s'
alias gcmd='git cmd'

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
alias pg="echo 'Pingign Google' && ping www.google.com"

#   Other
#   ---------------------------------------------------------------------------

alias cputop="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias checkcommand="type"
alias rebootsafe="sudo shutdown -r now"
alias rebootforce="sudo shutdown -r -n now"
alias cat='bat --paging=never' # cat: 'bat' modification for printing contents.
alias xcopy='xclip -sel clip'
alias xpaste='xclip -sel clip -o'
alias open='xdg-open'
