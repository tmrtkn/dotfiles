
filetype off

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  
  " use normal easymotion when in VIM mode
  Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
  " use VSCode easymotion when in VSCode mode
  Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
call plug#end()

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

colorscheme dracula


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

" Let mapleader be comma
let mapleader=","

" YAML specific indentations: https://stackoverflow.com/a/37488992
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>

" https://lornajane.net/posts/2018/vim-settings-for-working-with-yaml
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent

" If using list, use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

let g:netrw_altv=1

" Own Mappings {{{1
""""""""""""""
nnoremap <Leader>q :q<Cr>
nnoremap <Leader>w :w!<Cr>
nnoremap <Leader>bd :bd<Cr>

" In insert mode, it is quicker to exit to the normal mode
" just by quickly typing 'jk'
inoremap jk <esc>

nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>

" Split navigations
" 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Easier way to scroll buffers
" TODO: Make some vscode iffin here!
if exists('g:vscode')
    " VSCode extension
  nnoremap <Home> gT
  nnoremap <End> gt
else
    " ordinary Neovim
  nnoremap <Home> :bprevious<CR>
  nnoremap <End> :bnext<CR>
endif


" Toggle pastemode by using <F2>
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Search options {{{1
" set search case to a good configuration http://vim.wikia.com/wiki/Searching 
set ignorecase
set smartcase

" search characters as they're entered
set incsearch
" don't highlight all search matches
set nohlsearch

" No autmatic folding, please...
set nofoldenable

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

if exists('g:vscode')
    " VSCode extension
  set buftype=""
else
    " ordinary Neovim
endif

if (has("termguicolors"))
  set termguicolors
endif


