require('gitsigns').setup({
    signs = {
        delete = {text = '┃'},
        -- delete = {text = '█'},  -- experiment...
        changedelete = {text = '┃'},
    },
    signs_staged = {
        delete = {text = '┃'},
        changedelete = {text = '┃'},
    },
    current_line_blame_formatter = '<abbrev_sha> <summary> <author> <author_time:%Y-%m-%d>',
    numhl = true,
    preview_config = {
        border = 'rounded',
    },
})
