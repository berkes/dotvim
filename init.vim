set nocompatible            " disable compatibility to old-time vi
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set cc=80                   " set an 80 column border for good coding style
set ignorecase              " ignore case by default, unless search word contains uppercase
set smartcase               " ignore case by default, unless search word contains uppercase
set updatetime=300          " Set updatetime for CursorHold - 300ms of no cursor movement to trigger CursorHold
set clipboard+=unnamedplus  " Use system clipboard
set mouse=a                 " Enable mouse support for all (a) modes
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

" Fuzzy file finder with FZF but no plugins
" NOW WE CAN:
" - hit C-p to open fuzzy finder. Interactive update the result
" REQUIRED:
" Installed FZF https://github.com/junegunn/fzf#installation
set rtp+=~/.fzf/
" Bind FZF to CTRL-P
map <C-p> :FZF<CR>

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

" Content Searching
" NOW WE CAN:
" - Search for foo in current working directory: :grep foo.
" - Search for foo in files under src/: :grep foo src.
" - Search for foo in current file directory: :grep foo %:h1.
" - Search for foo in current file directory’s parent directory: :grep foo %:h:h (and so on).
" - Search for exact word foo in current working direcory: :grep -w foo.
" - Use the :Grep command instead to have a friendlier quickfix window opening
"   for us.
" KNOWN ISSUES:
" - needs ripgrep installed. Instructions here: https://github.com/BurntSushi/ripgrep#installation
" - it is synchronous and will block (is this actually true for nvim?)
" - searching backwards is somewhat daunting.
" - there is no quick way or mapping to Search for word under cursor. yet.
" - there is no quick way to search for last search like AgFromSearch() had.
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif
command! -nargs=+ Grep execute 'silent grep! <args>' | copen

" Allow W, WQ, Wq to work like their lowercase counterparts
" NOW WE CAN:
" - hold the shift a tad longer when typing :w. The : is behind shift.
" - fix common mistyped commands
map :W :w
map :Q :q
map :B :b

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

" Vim Papercolor Theme
Plug 'NLKNguyen/papercolor-theme'

" CMP complete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

" UltiSnips Snippets with integration in cmp
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Running tests
Plug 'vim-test/vim-test'

" Beancount.
" NOW WE CAN:
" - Syntax highlight beancount files"
" - run :make will run bean-check.
" KNOWN ISSUES:
" autocomplete is not configured (yet), needs integration in cmp to work.
Plug 'nathangrigg/vim-beancount'

" Eeasy vim-easy-align
" NOW WE CAN:
" - align on characters and expressions, such as =>, or :.
" - configure mappings (see below) to quickly align common blocks of code.
Plug 'junegunn/vim-easy-align'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Vim-Test Config 
" NOW WE CAN:
" - <leader>tt to run the test nearest to the cursor
" - <leader>tf to run the current file
" - <leader>ta to run all the tests
" - <leader>tl to run the last used test
" KNOWN ISSUES:
" - none
let test#strategy = "neovim"
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ta :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEMES and SYNTAX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme PaperColor

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust Analyzer. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
" NOW WE CAN:
" - Use context specific and language specific omnicomplete.
" - Get errors, warnings and linting directly in the editor.
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
EOF

" Ruby Solargraph. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
" NOW WE CAN:
" - Automcomplete, format, lint and errors in Ruby code.
lua << EOF
require'lspconfig'.solargraph.setup{}
EOF

" ESLint Javascript linting. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
" NOW WE CAN:
" - Run linters, checkers and autoformatters on JavaScript (and React) code.
lua << EOF
require'lspconfig'.eslint.setup{}
EOF

" Typescript support. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
" NOW WE CAN:
" - Autocomplete, import, fix and analyze Typescript.
" - Get errors and warnings directly in the editor.
lua << EOF
require'lspconfig'.tsserver.setup{}
EOF

" CSS support. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ssls
" NOW WE CAN:
" - Use contextual snippet support through neosnip.
lua << EOF
require'lspconfig'.cssls.setup{}
EOF

" Keybindings and Completion.
" See https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion for
" a full list of options and keybindings. Must work by default in vim, but
" improve a lot if the lsp version is used.
" NOW WE CAN:
" - Use LSP for omnicomplete.
lua << EOF
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Enforce the sign column to remain open. But only when we have an LSP,
  -- oterwise it's wasted space. This avoid jumping buffers when errors appear.
  vim.opt.signcolumn = "yes"

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'eslint' }
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Configure generic settings, applicable to all servers
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Configure specific settings, applicable to certain servers only
nvim_lsp.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  settings = {
    solargraph = {
      logLevel = "debug",
      formatting = true, -- Unclear from the docs whether this is on by default. We want formatting.
      autoformat = true, -- Experimental feature! Trying to see if this resonates.
      useBundler = true, -- So that we have access to all our local gems in our project
      diagnotistics = true
    }
  }
}
EOF

" Errors and diagnostics come from LSP.
" CursorHold timeout is set at top with `set updatetime`
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories=[$HOME."/Sjablonen/UltiSnips"]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CMP CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      { name = 'path' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyAlign CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
" NOW WE CAN:
" - type vipga to select inner paragraph (vip) and then align that.
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" NOW WE CAN:
" - type gaip to align inner paragraph (ip)
nmap ga <Plug>(EasyAlign)
