-- CMP (Completion) configurations

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- Setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'path' },
        { name = 'emoji', insert = true },
        { name = 'buffer', keyword_length = 5 },
    }),
    formatting = {
        fields = {'abbr', 'kind', 'menu'},
        format = function(entry, item)
            local icons = {
                nvim_lsp = '[LSP]',
                ultisnips = '[Snip]',
                path = '[Path]',
                emoji = '[Emoji]',
                buffer = '[Buffer]',
            }
            -- Concatenate the source name with the completion kind
            item.menu = icons[entry.source.name] or ''
            return item
        end,
    },
})

-- Setup buffer source for command-line mode completion (useful for searching in command mode)
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
