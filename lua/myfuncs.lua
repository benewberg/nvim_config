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

function fzf_ruff_diagnostics(opts)
    local fzf_lua = require'fzf-lua'
    opts = fzf_lua.defaults.diagnostics
    opts.actions = fzf_lua.defaults.actions.files
    fzf_lua.fzf_exec(vim.env.HOME .. "/.virtualenvs/nvim_exp/bin/python -m ruff --ignore=E501 --extend-select=W291,W293 " .. vim.fn.expand('%'), opts)
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
