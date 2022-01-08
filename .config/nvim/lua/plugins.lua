-- Plugins

return require('packer').startup(function(use)
  use 'itchyny/lightline.vim'
  use { 'dracula/vim', as = 'dracula' }

  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'mattn/emmet-vim'
  use 'christoomey/vim-tmux-navigator'
  use 'majutsushi/tagbar'
  use 'godlygeek/tabular'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'jvirtanen/vim-hcl'
  use 'hashivim/vim-terraform'
end)
