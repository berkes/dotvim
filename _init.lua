-- Comment.nvim Setup
require('Comment').setup()

-- Vim-Test Config
-- Key mappings:
-- - <leader>tt to run the test nearest to the cursor
-- - <leader>tf to run the current file
-- - <leader>ta to run all the tests
-- - <leader>tl to run the last used test
-- Known issues:
-- - none
vim.g['test#strategy'] = 'neovim'
vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ta', ':TestSuite<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', {silent = true, noremap = true})

-- Telescope Config
-- Key mappings:
-- - <leader>ff or <C-p> to find files
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files hidden=true<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', {noremap = true})

-- Color scheme and syntax
-- vim.opt.background = 'dark'
vim.cmd [[colorscheme catppuccin-macchiato]]

-- code folding
-- NOW WE CAN:
-- - za to toggle a fold
-- - zc to close a fold
-- - zo to open a fold
-- - zR to open all folds recursively
-- - zM to close all folds recursively
-- :help fold-commands
-- it uses the syntax highlighting to fold the code
vim.opt.foldenable = true
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = '0'
vim.opt.foldtext = 'foldtext#foldtext()'
