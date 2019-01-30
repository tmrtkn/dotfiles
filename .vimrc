set nocompatible              " be iMproved, required
set background=dark           " Set the background so that the colours are more visible on black background
filetype off                  " required

" Vundle plugin settings  
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugins {{{1
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-commentary'
" Plugin 'sjl/gundo.vim'

" tmux integration
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'

" Git related
" Plugin 'tpope/vim-fugitive'

" Parentheses (and such) handling
Plugin 'tpope/vim-surround'
Plugin 'luochen1990/rainbow'
" Plugin for inserting brackets, parentheses, quotes, etc in pairs
Plugin 'jiangmiao/auto-pairs'

" Clojure plugins start
" Plugin 'guns/vim-sexp'
" Plugin 'tpope/vim-sexp-mappings-for-regular-people'
" Plugin 'tpope/vim-fireplace'
" Plugin 'tpope/vim-salve'

" Python Plugins
" Plugin 'tmhedberg/SimpylFold'
" Plugin 'vim-scripts/indentpython.vim'

" Autocomplete
Plugin 'Valloric/YouCompleteMe'

" syntax checking
Plugin 'vim-syntastic/syntastic'

" PEP8 checking
" Plugin 'nvie/vim-flake8'

" Color scheme
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'jnurmine/Zenburn'
Plugin 'morhetz/gruvbox'

" Clojure plugins end

" Testing section
" Notes
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

" Plugin 'majutsushi/tagbar'


" Ansible stuff
" Plugin 'pearofducks/ansible-vim'


" All of your Plugins must be added before the following line }}}
call vundle#end()            " required
filetype plugin indent on    " required

" Rainbow plugin enable
let g:rainbow_active = 1

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax enable

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

" colorscheme solarized
" colorscheme Zenburn
colorscheme gruvbox
let g:gruvbox_contrast_dark="soft"

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

" Python stuff starts 
" Python related settings
au BufNewFile,BufRead *.py;
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Python: flag unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let python_highligh_all=1

" ----- Python stuff ends

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Let mapleader be comma
let mapleader=","

set foldmethod=indent
" set foldmethod=syntax
" Note, perl automatically sets foldmethod in the syntax file
" autocmd BufRead *.c,*.cpp,*.vim,*.xml,*.html,*.xhtml,.vimrc setlocal foldmethod=syntax
" autocmd BufRead * normal zR

" Autoformat XML files
au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"


" If using list, use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

let g:netrw_altv=1

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

" Split navigations
" 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Easier way to scroll buffers
nnoremap <Home> :bprevious<CR>
nnoremap <End> :bnext<CR>

" Toggle pastemode by using <F2>
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nnoremap <F3> :%! xmllint --format -<CR>

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
