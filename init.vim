set nocompatible            " disable compatibility to old-time vi
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

" Fuzzy file finder without plugins
" NOW WE CAN:
" - Hit tab to :find by partial match
" - use globs * to make it fuzzy
" KNOWN ISSUES:
" - ignore patterns like in .gitignore 
" - fuzzy-find hidden files need the .-prefix. E.g. ":find .git*hook"
set path+=**                " Add glob to files to search in current+subdirs
set wildmenu                " Display all matching files when we tab-complete
