-- ui
vim.fn['ddc#custom#patch_global']('ui', 'native')

-- sources
vim.fn['ddc#custom#patch_global']('sources', {
    'nvim-lsp',
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
        -- forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
        forceCompletionPattern = [[\.|:\w*|->\w*]],
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

-- enable
vim.fn["ddc#enable"]()
