set nocompatible            " disable compatibility to old-time vi
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set cc=100                   " set an 80 column border for good coding style
set ignorecase              " ignore case by default, unless search word contains uppercase
set smartcase               " ignore case by default, unless search word contains uppercase
set updatetime=300          " Set updatetime for CursorHold - 300ms of no cursor movement to trigger CursorHold
set clipboard+=unnamedplus  " Use system clipboard
set mouse=a                 " Enable mouse support for all (a) modes
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

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

" Source the plugin configurations
source ~/.config/nvim/plugged.vim

" Execute the main Lua configuration file
luafile ~/.config/nvim/_init.lua

" Load additional Lua configurations for LSP
luafile ~/.config/nvim/lsp.lua

" Load additional Lua configurations for CMP
luafile ~/.config/nvim/cmp.lua

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories=[$HOME."/Sjablonen/UltiSnips"]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyAlign CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipal)
" Start interactive EasyAlign for a motion/text object (e.g. alip)
"
" Default and common keybinding is ga, but that conflicts with lsp's
" code-actions. So we remap it to al.
" NOW WE CAN:
" - type vipal to select inner paragraph (vip) and then align that.
" - type alip to align inner paragraph (ip)
xmap al <Plug>(EasyAlign)
nmap al <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard fix workdaround. 
" Window started fllickering mostly when using netrw and clipboard integration.
" This is a workaround to prevent that from happening.
" see https://github.com/neovim/neovim/issues/9806#issuecomment-586666047 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable system clipboard integration
set clipboard+=unnamedplus
" Workaround for neovim wl-clipboard and netrw interaction hang 
" (see: https://github.com/neovim/neovim/issues/6695 and
" https://github.com/neovim/neovim/issues/9806) 
" let g:clipboard = {
"       \   'name': 'myClipboard',
"       \   'copy': {
"       \      '+': 'wl-copy',
"       \      '*': 'wl-copy',
"       \    },
"       \   'paste': {
"       \      '+': 'wl-paste -o',
"       \      '*': 'wl-paste -o',
"       \   },
"       \   'cache_enabled': 0,
"       \ }
" BK: above is not working. So we use the following workaround
" to prevent flickering: we disable the clipboard integration entirely.
" set clipboard=
