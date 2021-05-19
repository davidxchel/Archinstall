set number
set showbreak=+++
set wrap
set showmatch
set spell
set errorbells
set visualbell
set autoread

set tabstop=3
set shiftwidth=3
let $LANG='es'
set langmenu=es
set wildmenu
set lazyredraw
set magic
syntax enable
set encoding=utf8
 
set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set cindent
set smartindent
set smarttab
 
set ruler
set cursorline
set cursorcolumn
set relativenumber
set mouse=a
set title
set list
set listchars=tab:>~
set noexpandtab

set undolevels=1000
set backspace=eol,start,indent

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd VimEnter * set noexpandtab
