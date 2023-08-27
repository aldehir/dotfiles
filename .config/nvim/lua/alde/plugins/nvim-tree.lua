return function(lazyplugin, lazyopts)
  local nvim_tree = require('nvim-tree')

  nvim_tree.setup {
    view = {
      relativenumber = true,
    },

    actions = {
      open_file = {
        window_picker = {
          enable = true,
          chars = "123456789",
        },
      },
    },
  }

  vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')
end
