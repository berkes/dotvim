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

" Vim TokyoNight
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Telescope
" Ensure we have the latest version of fzf
" installed FZF https://github.com/junegunn/fzf#installation
" Now some other Telescope Dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" And telescope itself, using the release branch
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

" CMP complete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/nvim-cmp'

" UltiSnips Snippets with integration in cmp
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Copilot
Plug 'github/copilot.vim'

" Running tests
Plug 'vim-test/vim-test'

" Beancount.
" NOW WE CAN:
" - Syntax highlight beancount files"
" - run :make will run bean-check.
" KNOWN ISSUES:
" autocomplete is not configured (yet), needs integration in cmp to work.
Plug 'nathangrigg/vim-beancount'

" Slim template
" NOW WE CAN:
" - Syntax highlight slim files"
" TODO: remove when we're done with innxx project. Slim is hardly used.
Plug 'slim-template/vim-slim'

" Prisma Scheme
" NOW WE CAN:
" - Syntax highlight prisma scheme files
" TODO: remove when we're done with 10kb prisma stuff
Plug 'prisma/vim-prisma'

" Hurl syntax highlight
" NOW WE CAN:
" - Syntax highlight hurl files. See http://hurl.dev
Plug 'fourjay/vim-hurl'

" Eeasy vim-easy-align
" NOW WE CAN:
" - align on characters and expressions, such as =>, or :.
" - configure mappings (see below) to quickly align common blocks of code.
Plug 'junegunn/vim-easy-align'

" Comment tooling
" https://github.com/numToStr/Comment.nvim
" NOW WE CAN:
" - `gcc` - Toggles the current line using linewise comment
" - `gbc` - Toggles the current line using blockwise comment
" - `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
" - `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
" - visual: `gc` - Toggles the region using linewise comment
" - visual: `gb` - Toggles the region using blockwise comment
Plug 'numToStr/Comment.nvim'

" CSV plugin. Editing and syntax highlighting for CSV files.
"
" NOW WE CAN:
" - Syntax highlight CSV files
" - Operate on columns or rows. See :help csv
" - Insert new records with :NewRecord
Plug 'chrisbra/csv.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
