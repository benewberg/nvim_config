local lsp = require 'lspconfig'
lsp.pyright.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.codeActionProvider = false
        client.server_capabilities.executeCommandProvider = false
        on_attach(client, bufnr)
    end,
    cmd = {vim.env.HOME .. '/.virtualenvs/nvim_exp/bin/pyright-langserver', '--stdio'},
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
    },
    handlers = {
        ["textDocument/publishDiagnostics"] = function() end,
    },
}
lsp.ruff_lsp.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
    end,
    cmd = {vim.env.HOME .. '/.virtualenvs/nvim_exp/bin/ruff-lsp'},
    init_options = {
        settings = {
            args = {
                "--ignore=E501 --extend-select=W291,W293",
            },
        },
    },
}
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
})
