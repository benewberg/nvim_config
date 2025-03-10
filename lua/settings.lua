vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.completeopt = {'menuone,noinsert,noselect'}  -- completion options (for deoplete)
vim.opt.clipboard = 'unnamedplus'
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.shortmess:append({c = true})  -- ignore completions messages
vim.opt.showmode = false  -- not necessary with a statusline set
vim.opt.updatetime = 1000
vim.opt.timeoutlen = 200
vim.opt.colorcolumn = '100'
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.tags = vim.env.HOME .. '/.config/nvim/tags'
