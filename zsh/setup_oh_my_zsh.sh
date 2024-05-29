#!/usr/bin/env bash

if [ ! -d "ZSH" ]; then
    echo "Installing oh-my-zsh.."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "DONE!"
fi


if [ -f "$HOME/.zshrc" ]; then
    rm -v "$HOME/.zshrc"
fi


if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    echo "DONE!"
fi

echo "Installing pluings..."

PLUGINS="$ZSH_CUSTOM/plugins"

if [ ! -d "$PLUGINS/zsh-vi-mode" ]; then
    echo "Install vi-mode"
    git clone https://github.com/jeffreytse/zsh-vi-mode "$PLUGINS/zsh-vi-mode"
fi
if [ ! -d "$PLUGINS/zsh-autosuggestions" ]; then
    echo "Install autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS/zsh-autosuggestions"
fi
if [ ! -d "$PLUGINS/zsh-syntax-highlighting" ]; then
    echo "Install syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS/zsh-syntax-highlighting"
fi
if [ ! -d "$PLUGINS/fast-syntax-highlighting" ]; then
    echo "Install fast-syntax-highlighting"
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$PLUGINS/fast-syntax-highlighting"
fi
if [ ! -d "$PLUGINS/zsh-autocomplete" ]; then
    echo "Install autocomplete"
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$PLUGINS/zsh-autocomplete"
fi

echo "DONE"
