vim.g.python3_host_prog = vim.env.HOME .. "/.virtualenvs/nvim/bin/python3"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("plugin.treesitter")
        end,
    },
    {
        "saghen/blink.cmp",
        lazy = false,
        version = "v0.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<Tab>"] = {"select_next", "fallback"},
                ["<S-Tab>"] = {"select_prev", "fallback"},
                ["<CR>"] = {"select_and_accept", "fallback"},
            },
            highlight = {
                use_nvim_cmp_as_default = true,
            },
            nerd_font_variant = "mono",
            windows = {
                autocomplete = {
                    selection = "preselect",
                },
            },
        },
        -- allows extending the enabled_providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = {"sources.completion.enabled_providers"}
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {"saghen/blink.cmp"},
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            for server, config in pairs(opts.servers or {}) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    },
    {
        "ibhagwan/fzf-lua",
        config = function()
            require("plugin.fzf-lua")
        end,
    },
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugin.ayu")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugin.gitsigns")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("plugin.indent_blankline")
        end,
    },
    {
        "kylechui/nvim-surround",
        config = true,
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = function()
            require("plugin.leap")
        end,
    },
    {
        "numToStr/FTerm.nvim",
        event = "VeryLazy",
        config = function()
            require("plugin.fterm")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "echasnovski/mini.map",
        version = false,
        config = function()
            require("plugin.mini_map")
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("plugin.which-key")
        end,
    },
})

-- load modules ------------------------------------------------------------------------------------
require "lsp"
require "settings"
require "autocmds"
require "statusline"
require "disable_plugins"
require "myfuncs"
