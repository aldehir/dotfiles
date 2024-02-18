-- Plugins
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

require("lazy").setup({
  { 'nvim-lualine/lualine.nvim', config = require('alde.plugins.lualine') },

  { 'dracula/vim',
    name = 'dracula',
    config = function()
      vim.g.colors_name = 'dracula'

      vim.o.termguicolors = true
      vim.o.background = 'dark'

      vim.g.lightline = { colorscheme = 'dracula' }
    end,
  },

  { 'tpope/vim-fugitive' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'christoomey/vim-tmux-navigator' },


  { 'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = require('alde.plugins.telescope'),
  },


  { 'kyazdani42/nvim-tree.lua', config = require('alde.plugins.nvim-tree') },

  { 'windwp/nvim-autopairs', config = true },

  { 'nvim-treesitter/nvim-treesitter', config = require('alde.plugins.treesitter') },

  { 'hrsh7th/nvim-cmp',
    branch = 'main',
    config = require('alde.plugins.lsp'),
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp', branch = 'main' },
      { 'hrsh7th/cmp-buffer', branch = 'main' },
      { 'hrsh7th/cmp-path', branch = 'main' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },

      -- Zig
      { 'ziglang/zig.vim' },

      -- Go
      { 'ray-x/go.nvim', dependencies = { { 'ray-x/guihua.lua' } },
      },
    },
  },

  -- Ansible
  {
    'pearofducks/ansible-vim',
    init = function()
      vim.g.ansible_unindent_after_newline = 1
    end,
  }
})
