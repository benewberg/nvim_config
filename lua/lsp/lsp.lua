local lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')
end
lsp.pylsp.setup {
    on_attach = on_attach,
    root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd()),  -- start LSP server at project root or cwd
    cmd = {vim.env.HOME .. '/.virtualenvs/nvim/bin/pylsp'},
    settings = {
        pylsp = {
            plugins = {
                ruff = {
                    enabled = true,
                    executable = vim.env.HOME .. '/.virtualenvs/nvim/bin/ruff',
                    ignore = {"E501"},  -- ignore line length error
                    extendSelect = {"W291", "W293"},  -- whitespace warnings
                },
            },
        },
    },
}
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
})
