require("lint").linters_by_ft = {
    python = {"ruff",}
}
local ruff = require("lint").linters.ruff
ruff.cmd = vim.env.HOME .. '/.virtualenvs/nvim_exp/bin/ruff',
table.insert(ruff.args, "--ignore=E501")
table.insert(ruff.args, "--extend-select=W291,W293")
vim.api.nvim_create_autocmd({"BufEnter"}, {
    callback = function()
      require("lint").try_lint()
    end,
})
