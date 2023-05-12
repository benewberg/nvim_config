-- ui
vim.fn['ddc#custom#patch_global']('ui', 'native')

-- sources
vim.fn['ddc#custom#patch_global']('sources', {
    'around',
    'rg',
})

-- source options
vim.fn['ddc#custom#patch_global']('sourceOptions', {
    _ = {
        matchers = {'matcher_head', 'matcher_fuzzy'},
        sorters = {'sorter_rank', 'sorter_fuzzy'},
        converters = {'converter_fuzzy'},
        minAutoCompleteLength = 1,
        timeout = 500,
        dup = 'ignore',
    },
    ['nvim-lsp'] = {
        mark = '[lsp]',
        forceCompletionPattern = [[\s/\s*|\.|:\w*|->\w*]],
        isVolatile = true,
        -- maxItems = 4,
    },
    rg = {
        mark = '[rg]',
        minAutoCompleteLength = 4,
    },
    treesitter = {
        mark = '[treesitter]',
    },
    around = {
        mark = '[around]',
    },
})

-- source params
vim.fn['ddc#custom#patch_global']('sourceParams', {
    around = {
        maxSize = 1000,
    },
    ['nvim-lsp'] = {
        kindLabels = {
            Text = " Text",
            Method = " Method",
            Function = " Function",
            Constructor = " Constructor",
            Field = "ﰠ Field",
            Variable = " Variable",
            Class = "ﴯ Class",
            Interface = " Interface",
            Module = " Module",
            Property = "ﰠ Property",
            Unit = "塞 Unit",
            Value = " Value",
            Enum = " Enum",
            Keyword = " Keyword",
            Snippet = " Snippet",
            Color = " Color",
            File = " File",
            Reference = " Reference",
            Folder = " Folder",
            EnumMember = " EnumMember",
            Constant = " Constant",
            Struct = "פּ Struct",
            Event = " Event",
            Operator = " Operator",
            TypeParameter = "TypeParameter",
        },
    },
    treesitter = {},
})

-- custom settings for filetypes
vim.fn['ddc#custom#patch_filetype']('python', {
    sources = {
        'nvim-lsp',
        'treesitter',
        'around',
    },
})

-- mappings
-- vim.api.nvim_set_keymap('i', '<C-Space>', '<cmd>call ddc#map#manual_complete()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true, noremap = true})
-- enable
vim.fn["ddc#enable"]()
