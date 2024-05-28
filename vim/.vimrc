"   ----------------------------------------------------------------------------
"
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"
"   Description:  This file holds all settings for vim configurations
"
"   Sections:
"   1. General settings
"   2. Searching
"   3. Indents
"   4. Files settings
"   5. Plugins
"   6. Mappings
"   7. Vim scripting
"   8. Statusline
"
"   ----------------------------------------------* The config created by Qu1nel


"   -------------------------
"   1.  General settings
"   -------------------------

    set nocompatible			" Disable compatibility with vi which can cause unexpected issues.
    set number relativenumber	" Add numbers to each line on the left-hand side.
    set scrolloff=13			" Do not let cursor scroll below or above N number of lines when scrolling.
    set history=500             " Set the commands to save in history default number is 20.

    syntax on	    			" Turn sytax highlighting on.

    set encoding=utf8           " Set UTF-8 as standart encoding and en_US as standart language.
    set ffs=unix,dos,mac        " Use Unix as the standart file type.

    set guioptions=
    set showtabline=0

    set nowrap
    set textwidth=120

    set cursorline

    let &t_SI.="\e[5 q"
    let &t_SR.="\e[3 q"
    let &t_EI.="\e[1 q"

"   No sound
"   -------------------------
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500

"   Color
"   -------------------------
    if $COLORTERM == 'gnome-terminal'
        set t_Co=256
    endif

"   Wildmenu
"   -------------------------
    " There are certain files that we would never want to edit with Vim. Wildmenu will ignore files with these extensions.
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
    set wildmenu                " Enable auto completion menu after pressing TAB.
    set wildmode=list:longest   " Make wildmenu bahave like similar to Bash completion.


"   -------------------------
"   2.  Searching
"   -------------------------

    set incsearch               " While searching though a file incrementally highlight matching characters as you type.
    set ignorecase              " Ignore capital letters during search.
    set smartcase               " Ignore case when searching.
    set showmatch               " Show matching words during a search.
    set hlsearch                " Use highlighting when doing a search.


"   -------------------------
"   3.  Indents
"   -------------------------
"
    set shiftwidth=4			" Set shift width to 4 spaces.
    set tabstop=4				" Set tab width to 4 columns.
    set expandtab				" Use space characters instead of tabs.


"   -------------------------
"   4.  Files settings
"   -------------------------

    filetype on	    			" Enable type file detection. Vim will be able to try to detect the type of file in use.
    filetype plugin on			" Enable plugins and load plugin for the detected file type.
    filetype indent on			" Load an indent firl for the detected file type.

    set nobackup 				" Do not save backup files.
    set nowb
    set noswapfile


"   -------------------------
"   5.  Plugins
"   -------------------------

    call plug#begin('~/.vim/plugins')

    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'

    Plug 'wakatime/vim-wakatime'

    Plug 'morhetz/gruvbox'

    call plug#end()

"   Plugin settings
"   -------------------------

    " vim-airline
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#keymap#enable = 0
    let g:airline_section_z = "\ue0a1:%l/%L Col:%c"
    let g:Powerline_symbols='unicode'
    let g:airline_theme='gruvbox'

    colorscheme gruvbox
    set bg=dark


"   -------------------------
"   6.  Mappings
"   -------------------------

    inoremap kj <ESC>

    let mapleader = " "
    nnoremap <leader>, :nohlsearch<CR>  " Disable highlight search

    nnoremap yy y$                      " Yank from cursor to the end of line.

    " Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, CTRL+l.
    nnoremap <C-j> <C-W>j
    nnoremap <C-k> <C-W>k
    nnoremap <C-h> <C-W>h
    nnoremap <C-l> <C-W>l

    nnoremap <C-n> :bn<CR>
    nnoremap <C-p> :bp<CR>

    " Resize split windows using arrow keys by pressing:
    " Map Ctrl+[arrow] to navigate windows
    noremap <c-up> <c-w>+
    noremap <c-down> <c-w>-
    noremap <c-left> <c-w>>
    noremap <c-right> <c-w><

    " Fast saving
    nmap <C-W> :w!<CR>

    " Markdown preview
    nmap <leader>l <Plug>MarkdownPreview
    nmap <leader>s <Plug>MarkdownPreviewStop
    nmap <leader>p <Plug>MarkdownPreviewToggle

    set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz


"   -------------------------
"   7.  Vim scripting
"   -------------------------

    " This will enable code folding.
    " Use the marker method of folding.
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END

    " If the current file type is HTML, set indentation to 2 spaces, match pairs < >
    autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

    autocmd Filetype c,cpp,java setlocal mps+==:;
    autocmd Filetype make setlocal noexpandtab


"   -------------------------
"   8.  Statusline
"   -------------------------

    set guifont=FiraCode\ Nerd\ Font:h16

    "Show the mode you are on the last line.
    set showmode

    " Clear status line when vimrc is reloaded.
    set statusline=

    " Status line right side.
    set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

    " Show the status on the second to last line.
    set laststatus=2
