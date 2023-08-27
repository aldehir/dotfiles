return function(lazyplugin, lazyopts)
  local lualine = require('lualine')

  lualine.setup {
    options = {
      icons_enabled = true,
      theme = 'dracula',
    },

    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1,
        },
      },
    },
  }
end
