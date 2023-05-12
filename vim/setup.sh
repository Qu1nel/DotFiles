#!/usr/bin/env bash

syntaxVimPath="$HOME/.vim/syntax"
currentPath="${0%/*}"

mkdir -pv "$syntaxVimPath"

cp -vi "$currentPath/syntax/python_fold_indent.vim" "$syntaxVimPath"
cp -vi "$currentPath/.vimrc" "$HOME/"
