function abbrev(_text)
    local abbrev_text_table = {
        sbreak = '# ' .. string.rep('-', 94),
        lbreak = '# ' .. string.rep('-', 98),
        pdb = 'breakpoint()',
        this = 'from nose.plugins.attrib import attr<CR>@attr("this")',
    }
    local cmd = abbrev_text_table[_text]
    vim.api.nvim_command(vim.api.nvim_replace_termcodes('normal! O' .. cmd .. '<ESC><CR>', true, false, true))
end

function nt_cov()
    local cov = vim.fn.split(vim.fn.substitute(vim.fn.split(vim.fn.expand('%:p:h'), "python/")[2], "/", ".", "g"), ".tests")[1] .. "." .. vim.fn.substitute(vim.fn.substitute(vim.fn.substitute(vim.fn.expand('%'), "test_", "", ""), ".py", "", ""), "tests/", "", "g")
    local cov_cmd = "nosetests --with-cov --cov=" .. cov .. " --cov-report=term-missing " .. vim.fn.expand('%') .. " --verbose"
    return cov_cmd
end

function save_session()
    vim.ui.input({
        prompt = "Session name: ",
        default = '~/.local/share/nvim/sessions/',
        completion = 'file'
    },
    function(sessionName)
        if (sessionName ~= "" and sessionName ~= nil) then
            vim.fn.execute('mksession! ' .. vim.fn.fnameescape(sessionName))
        end
    end
    )
end

function fzf_git_blame(opts)
    local fzf_lua = require'fzf-lua'
    opts = fzf_lua.defaults.git.files
    opts.previewer = false
    opts.prompt = "Blame> "
    opts.cmd = "for i in " .. vim.api.nvim_buf_get_name(0) .. " ; do git blame --color-by-age ${i} ; done"
    opts.cwd = vim.fn.expand('%:p:h')
    fzf_lua.fzf_exec(opts.cmd, opts)
end

function toggle_text_wrap()
    local current_setting = vim.o.textwidth
    if current_setting == 0 then
        current_setting = 100
        print("text wrap on")
    else
        current_setting = 0
        print("text wrap off")
    end
    vim.o.textwidth = current_setting
end

function toggle_diagnostics()
    local current_setting = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({virtual_text = not current_setting, signs = not current_setting, underline = not current_setting})
end

function ruff_fix()
    local fterm = require'FTerm'
    local cmd = vim.env.HOME .. "/.virtualenvs/nvim_exp/bin/ruff --ignore=E501 --extend-select=W291,W293 --fix-only --exit-zero " .. vim.api.nvim_buf_get_name(0)
    fterm.scratch({cmd = cmd, hl = 'Normal,FloatBorder:FzfLuaBorder', on_exit = function() vim.fn.execute("checktime") end})  -- "checktime" will reload the buffer
end
