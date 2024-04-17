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

" Open all folds when opening a file
autocmd BufWinEnter * silent! :%foldopen!

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

" Comment.vim needs a call to setup after plug#end()
lua << EOF
require('Comment').setup()
EOF

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

" Telescope Config
" NOW WE CAN:
" - use <leader>ff or <C-p> to find files
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEMES and SYNTAX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme tokyonight-moon

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When debugging, set the log level to debug
" lua << EOF
" vim.lsp.set_log_level("debug")
" EOF

" Rust Analyzer. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
" NOW WE CAN:
" - Use context specific and language specific omnicomplete.
" - Get errors, warnings and linting directly in the editor.
lua << EOF
require'lspconfig'.rust_analyzer.setup {
  on_attach=on_attach;
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        extraArgs={"--target-dir", "/tmp/rust-analyzer-check"}
      }
    }
  }
}
EOF

" Ruby Solargraph. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
" NOW WE CAN:
" - Automcomplete, format, lint and errors in Ruby code.
lua << EOF
require'lspconfig'.solargraph.setup{}
EOF

" JavaScript and TypeScript support via deno. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#denols
" NOW WE CAN:
" - Autocomplete, import, fix and analyze JavaScript and TypeScript.
" - Use type hints and get errors and warnings directly in the editor.
" But only if we have deno installed and in use in the project.
lua << EOF
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
require'lspconfig'.denols.setup{}
EOF

" CSS support. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ssls
lua << EOF
require'lspconfig'.cssls.setup{}
EOF

" Python support. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
" Install Pyright with sudo snap install pyright --classic or another way.
" Pyright is ran with pipenv and the snap version of pyright. Pipenv so that
" we can use the correct version of Python for the project. Snap so that we
" can use the latest version of pyright without pip- or conda woes
" NOW WE CAN:
" - Autocomplete, import, fix and analyze Python.
" - Use type hints and get errors and warnings directly in the editor.
lua << EOF
require'lspconfig'.pyright.setup{}
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
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<space>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'pyright' }
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

" Open a list of all diagnostics with :ll
" :lua vim.lsp.diagnostic.set_loclist()

" Errors and diagnostics come from LSP.
" CursorHold timeout is set at top with `set updatetime`
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" Yank diagnostic error
" NOW WE CAN:
" - Copy the error message to the clipboard with <leader>e
lua << EOF
vim.api.nvim_set_keymap('n', '<leader>e', [[:lua YankDiagnosticError()<CR>]],
  { noremap = true, silent = true, desc = "Copy error" })

function YankDiagnosticError()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
  local win_id = vim.fn.win_getid()    -- get the window ID of the floating window
  vim.cmd("normal! j")                 -- move down one row
  vim.cmd("normal! VG")                -- select everything from that row down
  vim.cmd("normal! y")                 -- yank selected text
  vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end
EOF

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

  -- NOW WE CAN:
  -- - Use C-n and C-p to navigate the completion menu. Then C-y to select.
  -- - complete from lsp, snippets, path, emoji and buffer words.
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
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({ cmp.SelectBehavior.Insert} ), { "i" }),
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({ cmp.SelectBehavior.Insert }), { "i" }),
      ['<C-y>'] = cmp.mapping.confirm(
        { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        { "i", "c" }
      ), 
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      { name = 'path' },
      { name = 'emoji', insert = true  },
      { name = 'buffer', keyword_length = 5 },
    }),
    formatting = {
      fields = {'abbr', 'kind', 'menu'},
      format = function(entry, item)
        local menu_icon = {
          nvim_lsp = '[lsp ]',
          ultisnips = '[snip]',
          path = '[path]',
          emoji = '[emoj]',
          buffer = '[buff]',
        }

        item.menu = menu_icon[entry.source.name]
        return item
      end,
    },
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
