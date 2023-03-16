"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  

set nocompatible			" Disable compatibility with vi which can cause unexpected issues.
set number	    			" Add numbers to each line on the left-hand side.
set nobackup 				" Do not save backup files.
set scrolloff=13			" Do not let cursor scroll below or above N number of lines when scrolling.
set incsearch               " While searching though a file incrementally highlight matching characters as you type.
set ignorecase              " Ignore capital letters during search.
set showmatch               " Show matching words during a search.
set hlsearch                " Use highlighting when doing a search

set history=100             " Set the commands to save in history default number is 20.

set wildmenu                " Enable auto completion menu after pressing TAB.
set wildmode=list:longest   " Make wildmenu bahave like similar to Bash completion.

" There are certain files that we would never want to edit with Vim. Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set shiftwidth=4			" Set shift width to 4 spaces.
set tabstop=4				" Set tab width to 4 columns.
set expandtab				" Use space characters instead of tabs.

filetype on	    			" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype plugin on			" Enable plugins and load plugin for the detected file type.
filetype indent on			" Load an indent firl for the detected file type.

syntax on	    			" Turn sytax highlighting on.

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.dotfiles/vim/plugins')


call plug#end()

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

inoremap kj <ESC>

let mapleader = "/"
nnoremap <leader>/ :nohlsearch<CR>

nnoremap yy y$              " Yank from cursor to the end of line.

" Map the F5 for run a Python script inside Vim.
nnoremap <F5> :w <CR>:!clear <CR>:!python3 % <CR>

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, CTRL+l.
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" 'zo' to open one fold
" 'zc' to close one fold
" 'zR' to open all folds
" 'zM' to close all folds

" If the current file type is HTML, set indentation to 2 spaces, match pairs < >
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype html setlocal msp+=<:>

autocmd Filetype c,cpp,java setlocal mps+==:;

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

set showmode                " Show the mode you are on the last line.

" Clear status line when vimrc is reloaded.
set statusline=

" Status line right side.
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

" Show the status on the second to last line.
set laststatus=2

" }}}
