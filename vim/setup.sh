#!/bin/bash

syntaxVimPath="$HOME/.vim/syntax"

mkdir -p "$syntaxVimPath"

normalPath="$(dirname "$0")"

cp "$normalPath/syntax/python_fold_indent.vim" "$syntaxVimPath"
cp "$normalPath/.vimrc" "$HOME"
