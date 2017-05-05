" vim: foldmethod=marker
" vim: foldcolumn=3

set nocompatible              " be iMproved, required
set background=dark           " Set the background so that the colours are more visible on black background
filetype off                  " required

" Vundle plugin settings  {{{1
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugins {{{2
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-commentary'
Plugin 'sjl/gundo.vim'

" Git related
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Parentheses (and such) handling
Plugin 'tpope/vim-surround'
Plugin 'luochen1990/rainbow'
" Plugin for inserting brackets, parentheses, quotes, etc in pairs
Plugin 'jiangmiao/auto-pairs'

" Clojure plugins start
" Plugin 'guns/vim-sexp'
" Plugin 'tpope/vim-sexp-mappings-for-regular-people'
" Plugin 'tpope/vim-fireplace'
"Plugin 'tpope/vim-salve'
" Clojure plugins end

" All of your Plugins must be added before the following line }}}
call vundle#end()            " required
filetype plugin indent on    " required }}}

" Rainbow plugin enable
let g:rainbow_active = 1

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" show existing tab with 4 spaces width
set tabstop=4
" backspace deletes as many spaces as the tab adds
set softtabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Show line numbers
set number

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

" By default Vim saves your last 8 commands. We can handle more.
set history=100

" Vim UI {
"if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
"  let g:solarized_termcolors=256
"  let g:solarized_termtrans=1
"  let g:solarized_contrast="high"
"  let g:solarized_visibility="high"
"  colorscheme solarized             " Load a colorscheme
"  hi Normal ctermbg=NONE
" endif

" Reload vimrc any time it is changed
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has ('gui_running') | so $MYGVIMRC | endif
augroup END

" Let mapleader be comma
let mapleader=","

set foldmethod=syntax

" If using list, use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Own Mappings {{{1
""""""""""""""
nnoremap <Leader>q :q<Cr>
nnoremap <Leader>w :w!<Cr>

" In insert mode, it is quicker to exit to the normal mode
" just by quickly typing 'jk'
inoremap jk <esc>

nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>

" Swap colon and semicolon to avoid often unnecessary shift key
noremap ; :
noremap : ;

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Own mappings end }}}

" Search options {{{1
" set search case to a good configuration http://vim.wikia.com/wiki/Searching 
set ignorecase
set smartcase

" search characters as they're entered
set incsearch
" don't highlight all search matches
set nohlsearch

" Status line {{{1
" Always show the status line
set laststatus=2

" Status line itself
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%F\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%-16(%{exists('g:loaded_fugitive')?fugitive#statusline():''}\%)
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%c%V,%l/%L%)\ %<%P        " offset
