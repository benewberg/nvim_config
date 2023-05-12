-- ui
vim.fn['ddc#custom#patch_global']('ui', 'native')

-- sources
vim.fn['ddc#custom#patch_global']('sources', {
    'nvim-lsp',
    'rg',
    'around',
})

-- source options
vim.fn['ddc#custom#patch_global']('sourceOptions', {
    _ = {
        matchers = {'matcher_fuzzy'},
        sorters = {'sorter_fuzzy'},
        converters = {'converter_fuzzy'},
        minAutoCompleteLength = 1,
        timeout = 500,
        dup = 'ignore',
    },
    ['nvim-lsp'] = {
        mark = 'lsp',
        forceCompletionPattern = [[\S/\S*|\.|:\w*|->\w*]],
    },
    rg = {
        mark = 'rg',
        minAutoCompleteLength = 4,
    },
    around = {
        mark = 'A',
    },
})

-- source params
vim.fn['ddc#custom#patch_global']('sourceParams', {
    around = {
        maxSize = 1000,
    },
})

-- mappings
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true, noremap = true})
-- enable
vim.fn["ddc#enable"]()
