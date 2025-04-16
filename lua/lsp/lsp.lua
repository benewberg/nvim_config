-- local lsp = require 'lspconfig'
-- lsp.pylsp.setup {
--     root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd()),  -- start LSP server at project root or cwd
--     cmd = {vim.env.HOME .. '/.virtualenvs/nvim/bin/pylsp'},
-- }
-- python lsp server
vim.lsp.config["pylsp"] = {
    cmd = { vim.env.HOME .. '/.virtualenvs/nvim/bin/pylsp' },
    filetypes = { "python" },
    settings = {
        pylsp = {
            plugins = {
                ruff = {
                    enabled = true,
                    executable = vim.env.HOME .. '/.virtualenvs/nvim/bin/ruff',
                    ignore = {"E501"},  -- ignore line length error
                    extendSelect = {"W291", "W293"},  -- whitespace warnings
                    -- TODO add to extendSelect when available: E1120, ...
                    -- see astral-sh / ruff / issues / 970
                },
            },
        },
    },
}
vim.lsp.enable("pylsp")

-- completion options
vim.opt.completeopt = { 'menuone,noinsert,noselect,popup,fuzzy' }

-- handle lsp autocompletion
local kind_icons = {
    Text = "",
    Method = "",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "𝒙",
    Class = "",
    Interface = "󰆧",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "󰘍",
    Color = "",
    File = "",
    Reference = "󰌹",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
    Unknown = "?",
}

local function keycode(keys)
    return vim.api.nvim_replace_termcodes(keys, true, false, true)
end

local pumMaps = {
    ['<Tab>'] = '<C-n>',
    ['<S-Tab>'] = '<C-p>',
}
for insertKmap, pumKmap in pairs(pumMaps) do
    vim.keymap.set('i', insertKmap, function()
        if vim.fn.pumvisible() == 1 then
            vim.api.nvim_feedkeys(keycode(pumKmap), 'n', false)
        else
            vim.api.nvim_feedkeys(keycode(insertKmap), 'n', false)
        end
    end, { expr = true })
end
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm.", "")
        -- necessary to have the popup menu re-display if a backspace used
        vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
            buffer = args.buf,
            callback = function()
                vim.lsp.completion.get()
            end
        })
        vim.lsp.completion.enable(true, client.id, args.buf, {
            autotrigger = true,
            convert = function(item)
                local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'Unknown'
                local kind_icon = kind_icons[kind]
                local entry = {
                    abbr = item.label,
                    kind = kind_icon .. ' ' .. kind,
                    menu = item.detail or '',
                    icase = 1,
                    dup = 0,
                    empty = 0,
                }
                return entry
            end,
        })
    end
})

-- turn off diagnostics by default
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
})
