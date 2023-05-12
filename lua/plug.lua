local Plug = vim.fn['plug#']
vim.g.plug_home = vim.fn.stdpath('config') .. '/plugged'

vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter', {branch = 'v0.9.0'})

-- ddc
Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'
--   ui
Plug 'Shougo/ddc-ui-native'
--   sources
Plug 'Shougo/ddc-source-around'
Plug 'Shougo/ddc-source-nvim-lsp'
Plug 'Shougo/ddc-source-rg'
Plug 'delphinus/ddc-treesitter'
--   filters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
Plug 'tani/ddc-fuzzy'

Plug 'neovim/nvim-lspconfig'
Plug 'ibhagwan/fzf-lua'
Plug 'Shatur/neovim-ayu'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'kylechui/nvim-surround'
Plug 'ggandor/leap.nvim'
Plug 'numToStr/FTerm.nvim'
Plug 'folke/which-key.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'echasnovski/mini.map'
vim.call('plug#end')    -- automatically calls `filetype plugin indent on` and `syntax enable`
