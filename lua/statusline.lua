function get_mode_color(mode)
    local mode_color = '%#OtherMode#'
    local mode_color_table = {
        n = '%#NormalMode#',
        i = '%#InsertMode#',
        R = '%#ReplaceMode#',
        v = '%#VisualMode#',
        V = '%#VisualMode#',
        [''] = '%#VisualMode#',
    }
    if mode_color_table[mode] then
        mode_color = mode_color_table[mode]
    end
    return mode_color
end

function get_readonly_char()
    local ro_char = ''
    if vim.bo.readonly or vim.bo.modifiable == false then ro_char = '' end
    return ro_char
end

function get_cwd(shorten)
    local dir = vim.api.nvim_call_function('getcwd', {})
    if shorten then
        dir = vim.api.nvim_call_function('pathshorten', {dir})
    end
    return dir
end

function gitsigns_status(key)
    local summary = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
    if summary[key] == nil then return '' end
    if summary[key] == '' then return '' end
    if summary[key] == 0 then return '' end
    local prefix = {head = ' ', added = '+', changed = '~', removed = '-'}
    return string.format(" %s%s ", prefix[key], summary[key])
end

function status_line()
    local status = ''
    status = status .. get_mode_color(vim.fn.mode()) .. [[ %-"]]
    status = status .. [[%#GitSignsAdd#%-{luaeval("gitsigns_status('head')")}]]
    status = status .. [[%#GitSignsAdd#%-{luaeval("gitsigns_status('added')")}]]
    status = status .. [[%#GitSignsChange#%-{luaeval("gitsigns_status('changed')")}]]
    status = status .. [[%#GitSignsDelete#%-{luaeval("gitsigns_status('removed')")}]]
    status = status .. '%#Directory# '
    status = status .. '%='
    status = status .. [[%-{luaeval("get_cwd(false)")} ]]
    return status
end

vim.opt.statusline = '%!luaeval("status_line()")'

-- winbar
function win_bar()
    local file_path = vim.fn.expand('%:~:.:h')
    local filename = vim.fn.expand('%:t')
    local value = ' '

    file_path = file_path:gsub('^%.', '')
    file_path = file_path:gsub('^%/', '')

    if not (filename == nil or filename == '') then
        file_icon = ' '
        file_icon = '%#WinBarIcon#' .. file_icon .. '%*'
        dir_icon = ' '
        dir_icon = '%#WinBarIcon#' .. dir_icon .. '%*'

        local file_path_list = {}
        local _ = string.gsub(file_path, '[^/]+', function(w)
            table.insert(file_path_list, w)
        end)

        for i = 1, #file_path_list do
            value = value .. dir_icon .. file_path_list[i] .. '%#WinBarDirSep# / %*'
        end
        local file_modified = ''
        if vim.bo.modified then
            file_modified = '%#WinBarModified#●%*'
        end
        value = value .. file_icon .. filename .. ' ' .. file_modified .. ' %-{luaeval("get_readonly_char()")}%#NonText#%'
    end
    return value
end

vim.opt.winbar = '%!luaeval("win_bar()")'
vim.opt.laststatus = 3
