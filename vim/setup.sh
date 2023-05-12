#!/usr/bin/env bash

syntaxVimPath="$HOME/.vim/syntax"

mkdir -pv "$syntaxVimPath"

currentPath="${0%/*}"

# cp "$currentPath/syntax/python_fold_indent.vim" "$syntaxVimPath"
# cp "$currentPath/.vimrc" "$HOME"
