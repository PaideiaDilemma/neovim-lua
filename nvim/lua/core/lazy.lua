-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

-- Start setup
lazy.setup({
  spec = {
    -- Colorscheme:
    -- The colorscheme should be available when starting Neovim.
    {
      'PaideiaDilemma/penumbra.nvim',
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
    },

    -- other colorschemes:
    'navarasu/onedark.nvim',
    { 'tanvirtin/monokai.nvim', lazy = true },
    { 'https://github.com/rose-pine/neovim', name = 'rose-pine', lazy = true },

    -- Icons
    { 'kyazdani42/nvim-web-devicons', lazy = true },

    -- Dashboard (start screen)
    {
      'goolord/alpha-nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    -- Git labels
    {
      'lewis6991/gitsigns.nvim',
      lazy = true,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('gitsigns').setup{}
      end
    },

    -- File explorer
    {
      'kyazdani42/nvim-tree.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    -- Statusline
    {
      'freddiehaddad/feline.nvim',
      dependencies = {
        'kyazdani42/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
      },
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Indent line
    { 'lukas-reineke/indent-blankline.nvim' },

    -- Tag viewer
    { 'preservim/tagbar' },

    -- Autopair
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup{}
      end
    },

    -- LSP
    {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-lint'
    },

    -- Autocomplete
    {
      'hrsh7th/nvim-cmp',
      -- load cmp on InsertEnter
      event = 'InsertEnter',
      -- these dependencies will only be loaded when cmp loads
      -- dependencies are always lazy-loaded unless specified otherwise
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
      },
    },

    -- Markdown
    {
      'iamcco/markdown-preview.nvim',
      build = function()
        vim.fn["mkdp#util#install"]()
      end
    },

    -- Telescope
    {
      'nvim-telescope/telescope.nvim', branch = '0.1.x',
      dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = [[
        cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&
        cmake --build build --config Release &&
        cmake --install build --prefix build]]
    },

    -- Vscode like goto references/definitions
    {
      'dnlhc/glance.nvim'
    },

    -- Based number conversion
    {
      'trmckay/based.nvim'
    },

    {
      'folke/which-key.nvim',
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup{}
      end
    },

    {
      'echasnovski/mini.nvim',
      version = false
    },

    {
      'lervag/vimtex',
      config = function()
        vim.g.vimtex_view_general_viewer = 'okular'
        vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
      end
    },

    {
      "iurimateus/luasnip-latex-snippets.nvim",
      -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
      -- using treesitter.
      dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
      config = function()
        require('luasnip-latex-snippets').setup()
        -- or setup({ use_treesitter = true })
      end,
      -- treesitter is required for markdown
      ft = { "tex", "markdown" },
    },
    {
      'nvim-treesitter/nvim-treesitter-context'
    },
  },
})
