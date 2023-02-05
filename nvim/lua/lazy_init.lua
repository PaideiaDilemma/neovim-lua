-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Automatically install lazy
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


-- Install plugins
-- Add you plugins here:
require("lazy").setup({
  -- File explorer
  'kyazdani42/nvim-tree.lua',

  -- Indent line
  'lukas-reineke/indent-blankline.nvim',

  -- Autopair
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  },

  -- Icons
  'kyazdani42/nvim-web-devicons',

  -- Tag viewer
  'preservim/tagbar',

  -- Treesitter interface
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  },

  -- Color schemes
  'navarasu/onedark.nvim',
  'PaideiaDilemma/penumbra.nvim',
  'tanvirtin/monokai.nvim',
  { 'rose-pine/neovim', name = 'rose-pine' },

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
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- Statusline
  {
    'feline-nvim/feline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },

  -- git labels
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {}
    end
  },

  -- Dashboard (start screen)
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
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

  {
    'debugloop/telescope-undo.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require("telescope").load_extension("undo")
    end,
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
  }
})
