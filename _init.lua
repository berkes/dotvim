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
