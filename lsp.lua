-- lsp.lua
-- LSP configurations for Neovim using Lua

-- Setup basic LSP functionality
local nvim_lsp = require('lspconfig')

-- Utility functions for on_attach to bind key mappings and options
local on_attach = function(client, bufnr)
    local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local buf_set_option = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Keep the sign column open to avoid shifting the text
    vim.opt.signcolumn = "yes"

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('v', '<space>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

-- Enhanced LSP capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- General settings and servers setup
local servers = { 'rust_analyzer', 'pyright', 'tsserver', 'solargraph', 'cssls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

-- Rust Analyzer specific settings
nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                extraArgs = {"--target-dir", "/tmp/rust-analyzer-check"}
            }
        }
    }
}

-- Solargraph specific settings
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
            formatting = true,
            autoformat = true,
            useBundler = true,
            diagnotistics = true
        }
    }
}

-- Vimscript compatibility: Set up diagnostics to appear on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end
})

-- Keybindings for navigating diagnostics
vim.api.nvim_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true, noremap = true })

-- Optional: Set LSP log level to debug
-- Uncomment to enable verbose logging for troubleshooting
-- vim.lsp.set_log_level("debug")

-- Yank diagnostic error
-- NOW WE CAN:
-- - Copy the error message to the clipboard with <leader>e
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
