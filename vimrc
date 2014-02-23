"Pathogen as per https://github.com/tpope/vim-pathogen
call pathogen#infect()

set nocompatible

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

" CTRL-P Configuration
" Open new file in curent window (r) instead of default vertical split (v)
let g:ctrlp_open_new_file = 'r'
map <Leader>b :CtrlPBuffer<CR>

" Tagbar configuration
map <Leader>f :TagbarToggle<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <Leader>rtr :!ctags --extra=+f --exclude=.git --exclude=log -R * `rvm gemdir`/gems/*<CR><CR>

map <C-\> :tnext<CR>

" Investigate Documentation
nnoremap K :call investigate#Investigate()<cr>

" Relative numbering and toggling thereof
set relativenumber
" On focus (we are in Vim) show relative numbering, else show normal numbers
:au FocusLost * :set number
:au FocusGained * :set relativenumber
" Show normal numbering in insert mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \ set ft=markdown |
      \ else |
      \ setf markdown |
      \ endif
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()
" drupalfiles are PHP
au BufRead,BufNewFile *.{module,theme,inc,install,engine,profile,test} set ft=drupal.php

" scad files are openscad
au Bufread,BufNewFile *.scad set filetype=openscad

" json must not use autohide
let g:vim_json_syntax_conceal = 0

" Allow W, WQ, Wq to work like their lowercase counterparts
map :W :w
map :Q :q
map :B :b

" delete a buffer without closing its window
nnoremap <C-c> :bp\|bd #<CR>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Use modeline overrides
set modeline
set modelines=10

" Directories for swp files
set backupdir=~/.vim
set dir=~/.vim

" Buffer management
" Allow switching between buffers, even if they have changes.·
set hidden

" Airline Vim Symbol fonts
let g:airline_powerline_fonts = 1

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>
