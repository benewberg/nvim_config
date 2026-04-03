vim.g.python3_host_prog = vim.env.HOME .. "/.virtualenvs/nvim/bin/python3"
vim.g.mapleader = " "

-- define the plugins (will install if missing)
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/Shatur/neovim-ayu" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim", name = "ibl" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/numToStr/FTerm.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/folke/which-key.nvim" },
})

-- define any non-github plugins by name after cloning them into the packpath manually
-- ex: mkdir -p $HOME/.local/share/nvim/site/pack/ext/opt
--     git clone https://codeberg.org/<maintainer/<plugin> $HOME/.local/share/nvim/site/pack/ext/opt/<plugin>
vim.cmd.packadd("leap.nvim")

-- activate / start plugins
require("plugin.treesitter")
require("plugin.fzf-lua")
require("plugin.ayu")
require("plugin.gitsigns")
require("plugin.indent_blankline")
require("plugin.fterm")
require("nvim-autopairs").setup()
require("plugin.which-key")
require("plugin.leap")

-- activate other builtin plugins
vim.cmd.packadd("nvim.undotree")

-- load other modules
require "lsp"
require "settings"
require "autocmds"
require "statusline"
require "disable_plugins"
require "utils"
