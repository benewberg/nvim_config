local lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
    client.server_capabilities.codeActionProvider = false
    client.server_capabilities.executeCommandProvider = false
end
lsp.pyright.setup(require('coq').lsp_ensure_capabilities({
    on_attach = on_attach,
    cmd = {vim.env.HOME .. '/.virtualenvs/nvim_exp/bin/pyright-langserver', '--stdio'},
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                autoImportCompletions = false,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
            }
        },
    },
    handlers = {
        ["textDocument/publishDiagnostics"] = function() end,
    },
}))
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
})
