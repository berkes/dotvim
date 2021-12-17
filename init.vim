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

" Tag jumping
" NOW WE CAN:
" - run :MakeTags to make the tags file
" - Use ^] to jump to tag under cursor
" - Use g^] for ambigous tags
" - Use ^t to jump back up the tag stack
" KNOWN ISSUES:
" - ignore patterns like in .gitignore 
" - does not include libraries and gems packed outside of directory structure
command! MakeTags !ctags -R .

" File Browsing
" NOW WE CAN:
" - :Explore to browse the file system
" - type `-` as shortcut for :Explore
" KNOWN ISSUES:
" - does not follow the current file.
" - netrw *is* a known issue. It is clunky and not very ergonomic. But simple
"   and present.
let g:netrw_banner=0      " disable the information banner
nnoremap - :Explore<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" LSP. Built into nvim 0.6.x but must be configured to run:
" NOW WE CAN:
" - configure an existing language server to be automatically started for
"   projects
" - Use omnifunc (<c-x><c-o>) to complete based on actual language settings.
Plug 'neovim/nvim-lspconfig'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
