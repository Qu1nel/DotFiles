"=============================================================================
" GENERAL
"=============================================================================

syntax on

set mouse=a
set mousehide
set scrolloff=7
set number
set t_vb=  " no sound 
set visualbell t_vb=  " off sound in vim
set novisualbell
set showtabline=1
set backspace=indent,eol,start, whichwrap+=<,>,[,]  " smart backspace
set undofile  " save changes after reboot
set fileformat=unix
set noswapfile
set nobackup

" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf8,cp1251

" Indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
filetype indent on

" BackSpace
set nowrap
set linebreak
set formatoptions-=cro

" Enable 'smart' indent after spec-key (for .py .c .cpp .cc)
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,der,class
autocmd BufRead *.c set smartindent cinwords=if,else,for,while
autocmd BufRead *.cpp set smartindent cinwords=if,else,for,while
autocmd BufRead *.cc set smartindent cinwords=if,else,for,while

" Cut the spaces at the ends of files (for .py .c .cpp .cc)
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.cpp :%s/\s\+$//e
autocmd BufWritePre *.cc :%s/\s\+$//e

" Other
set colorcolumn=79
let python_highlight_all = 1

" Colors
set t_Co=256
highlight ColorColumn ctermbg=grey
set termguicolors

" Search
set ic
set is


"=============================================================================
" PLUGINS
"=============================================================================

call plug#begin('~/.config/nvim/plugged/')

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/sonokai'
Plug 'cocopon/iceberg.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'Mofiqul/vscode.nvim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}

Plug 'vim-airline/vim-airline'

" Auto-pairs
Plug 'jiangmiao/auto-pairs'

"Grammar checking because I can't english
Plug 'rhysd/vim-grammarous'

" Comments
Plug 'tpope/vim-commentary'

" Folder Tree
Plug 'preservim/nerdtree'

" Icons for Folder Tree
Plug 'ryanoasis/vim-devicons'

" tags for classes, vars and more
Plug 'preservim/tagbar'  " sudo apt install exuberant-ctags

" Smooth scrolling
Plug 'yuttie/comfortable-motion.vim'

" Display margins
Plug 'nathanaelkane/vim-indent-guides'

" Colorschemes dependign on the file
Plug 'caglartoklu/ftcolor.vim'

" TODO
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'

cal plug#end()


"=============================================================================
"  SETTING FOR PLUGINS
"=============================================================================

" For 'nerdtree'
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" For 'comfortable-motion'
nnoremap <silent> <C-j> :call comfortable_motion#flick(80)<CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(-80)<CR>
nnoremap <silent> <A-m> :call comfortable_motion#flick(120)<CR>
nnoremap <silent> <A-,> :call comfortable_motion#flick(-120)<CR>
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 5.0

" For 'vim-commentary'
inoremap <C-.> gcc

" For 'tagbar'
nmap <F8> :TagbarToggle<CR>

" For 'coc.nvim'
nmap <silent> gd <Plug>(coc-definition)
set completeopt-=preview

" For 'vim-indent-guides'
map <F5> :IndentGuidesToggle<CR>

" For 'AutoPairs'
au Filetype FILETYPE let b:AutoPairs = {"(": ")", "{": "}", "[": "]"}

" For 'ftcolor.vim'
let g:ftcolor_redraw = 1
let g:ftcolor_default_color_scheme = 'catppuccin'
let g:ftcolor_color_mappings = {}
let g:ftcolor_color_mappings.python = 'gruvbox'
let g:ftcolor_color_mappings.c = 'vscode'
let g:ftcolor_color_mappings.cpp = 'ayu'

" Theme ayu-vim
let ayucolor="mirage"  " light, mirage, dark

" Theme catppuccin
let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
lua << EOF
require("catppuccin").setup()
EOF

" TODO 
lua << EOF
  require("todo-comments").setup {
     -- configs
  }
EOF


"=============================================================================
"  KEYS
"=============================================================================

inoremap kj <ESC>
nnoremap ,<space> :nohlsearch<CR>
nnoremap <C-v> <ESC>"+pa <ESC>
vnoremap <C-c> "+y
inoremap <C-z> <ESC>"+ua
