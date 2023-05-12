local group = vim.api.nvim_create_augroup("MyAutogroups", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank {timeout = 400}
    end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    pattern = "*",
    callback = function()
        vim.cmd("IndentBlanklineRefresh")
    end,
})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.py",
    group = group,
    callback = function()
        local timeout = 500
        local num_lines = vim.api.nvim_buf_line_count(0)
        if num_lines > 500 then  -- arbitrary number chosen
            timeout = 5000
        end
        vim.fn['ddc#custom#patch_global']('sourceOptions', { _ = {timeout = timeout}})
    end,
})
