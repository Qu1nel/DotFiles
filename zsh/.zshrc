if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

ENABLE_CORRECTION="true"
HIST_STAMPS="mm/dd/yyyy"

zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
compinit

# -----------------------------------------------------------------------------

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    dotenv
    extract
    history
    sudo
    git
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-autocomplete
    zsh-vi-mode
)

ZSH_DOTENV_FILE=.env
ZVM_VI_INSERT_ESCAPE_BINDKEY=kj

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

unsetopt correct_all
unsetopt correct

ENABLE_CORRECTION="true"
