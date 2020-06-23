"Pathogen as per https://github.com/tpope/vim-pathogen
call pathogen#infect()

set nocompatible

" Enable matchit
runtime macros/matchit.vim

" Set filetype off for the vundle part.
" It will be enabled below.
" See http://stackoverflow.com/a/17045575/73673
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Powerline, Lightweight
Plugin 'bling/vim-airline'

" Vinegar, file and disk browsing, nerdtree alternative
Plugin 'tpope/vim-vinegar'

" Vim-tags: enhance tags support for a.o. Gemfile support.
Plugin 'szw/vim-tags'

" Ag, Silver Searcher
Plugin 'vim-scripts/ag.vim'

" Neocomplete, with snippets
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'honza/vim-snippets'

" Simple commenting and uncommenting
Plugin 'scrooloose/nerdcommenter'

" Align
Plugin 'junegunn/vim-easy-align'

" Surround, matching pairs.
Plugin 'tpope/vim-surround'

"" Ruby and Rails helpers
" Rails helpers
Plugin 'tpope/vim-rails'
" Ruby Blocks, requires textobj-user
" Plugin 'kana/vim-textobj-user'
" Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'vim-ruby/vim-ruby'

"" Rust helpers
Plugin 'rust-lang/rust.vim'

" Syntax Checking
Plugin 'scrooloose/syntastic'

" Git wrapper
Plugin 'tpope/vim-fugitive'

"" Filetype Support
" OpenScad
Plugin 'torrancew/vim-openscad'
" Todotxt
Plugin 'vim-scripts/todotxt.vim'
" Slim template language
Plugin 'slim-template/vim-slim'
" JSON
Plugin 'elzr/vim-json'
" Markdown
Plugin 'plasticboy/vim-markdown'
" Solitidy
Plugin 'tomlion/vim-solidity'
" Vue
Plugin 'posva/vim-vue'
" Beancount
Plugin 'nathangrigg/vim-beancount'

"" Colorschemes
Plugin 'altercation/vim-colors-solarized'

set number
set ruler
set colorcolumn=80
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

" Generic ignore for generated Rails Doc
" e.g. ctrp-p will use this when searching for files
set wildignore+=*/doc/*,*/tmp/*,*/vendor/*,*/node_modules/*

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" Leader
let mapleader="\<Space>"

" Neocomplete configuration
" Disable AutoComplPop.
 let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" incompatibityfix with vim-rails: https://github.com/tpope/vim-rails/issues/283
let g:neocomplete#force_overwrite_completefunc = 1

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Snippet Configuration
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Enable snipMate compatibility feature.
let g:neosnippet#disable_runtime_snippets = { "_": 1, }

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'

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

" Install FZF
" https://github.com/junegunn/fzf#installation
set rtp+=~/.fzf/
" Bind FZF to CTRL-P
map <C-p> :FZF<CR>

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Kiba etl, Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,*.etl} set ft=ruby

" md, markdown, and mk are markdown
au BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \ set ft=markdown |
      \ else |
      \ setf markdown |
      \ endif|
      \ call s:setupWrapping()
" vim-markdown default folds at level 1. We want all headers to show.
let g:vim_markdown_folding_disabled = 1

au BufRead,BufNewFile *.txt call s:setupWrapping()

" scad files are openscad
au Bufread,BufNewFile *.scad set filetype=openscad

" json must not use autohide
let g:vim_json_syntax_conceal = 0

" Allow W, WQ, Wq to work like their lowercase counterparts
map :W :w
map :Q :q
map :B :b

" a quick command to store as sudo.
cabbr sandwich w !sudo tee %

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages= {'level': 'warnings'}
" Syntastic JS
let g:syntastic_javascript_checkers=['standard']

" Use modeline overrides
set modeline
set modelines=10

" Directories for swp files
set backupdir=~/.vim
set dir=~/.vim

" Buffer management
" Allow switching between buffers, even if they have changes.·
set hidden
" Add a shortcut for closing a buffer without closing the window.
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Airline Vim Symbol fonts
let g:airline_powerline_fonts = 1

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" beancount Add through snippets
command -nargs=+ BeanAdd :r !/home/ber/Administratie/beancount/add.rb <args>
