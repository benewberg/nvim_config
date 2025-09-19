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

-- completion options
vim.opt.completeopt = { 'menuone,noselect,popup,fuzzy' }
vim.opt.pumheight = 20

-- local lsp = require 'lspconfig'
-- lsp.pylsp.setup {
--     root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd()),  -- start LSP server at project root or cwd
--     cmd = {vim.env.HOME .. '/.virtualenvs/nvim/bin/pylsp'},
-- }

-- python lsp server
vim.lsp.config["pylsp"] = {
    cmd = { vim.env.HOME .. '/.virtualenvs/nvim/bin/pylsp' },
    -- root_dir = vim.lsp.util.root_pattern('.git', vim.fn.getcwd()),  -- start LSP server at project root or cwd
    -- root_markers = { ".git" },
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
    on_attach = function(client, bufnr)
        local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
        client.server_capabilities.completionProvider.triggerCharacters = chars
        client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm.", "")
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'Unknown'
                local kind_icon = kind_icons[kind]
                local entry = {
                    abbr = kind_icon .. ' ' .. item.label,
                    kind = kind,
                    menu = item.detail or '',
                    icase = 1,
                    dup = 0,
                    empty = 0,
                }
                return entry
            end,
        })
    end,
}
vim.lsp.enable("pylsp")

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

-- local function is_whitespace()
--     local col = vim.fn.col('.') - 1
--     local line = vim.fn.getline('.')
--     local char_under_cursor = string.sub(line, col, col)
--     ret_val = false
--     if col == 0 or string.match(char_under_cursor, '%s') then
--         ret_val = true
--     end
--     return ret_val
-- end
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--         client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm.", "")
--         -- necessary to have the popup menu re-display if a backspace used
--         vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
--             buffer = args.buf,
--             callback = function()
--                 if not is_whitespace() then
--                     vim.lsp.completion.get()
--                 end
--             end
--         })
--         vim.lsp.completion.enable(true, client.id, args.buf, {
--             autotrigger = true,
--             convert = function(item)
--                 local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'Unknown'
--                 local kind_icon = kind_icons[kind]
--                 local entry = {
--                     abbr = kind_icon .. ' ' .. item.label,
--                     kind = kind,
--                     menu = item.detail or '',
--                     icase = 1,
--                     dup = 0,
--                     empty = 0,
--                 }
--                 return entry
--             end,
--         })
--     end
-- })
--
-- turn off diagnostics by default
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
})
