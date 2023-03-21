#!/bin/bash

syntaxVimPath="$HOME/.vim/syntax"

mkdir -p "$syntaxVimPath"

normalPath=$(dirname $0)

cp "$normalPath/python_fold_indent.vim" "$syntaxVimPath"
cp "$normalPath/.vimrc" "$HOME"
