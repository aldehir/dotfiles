return function(lazyplugin, lazyopts)
  local config = require('nvim-treesitter.configs')

  config.setup({
    highlight = {
      enable = true,
    },
  })
end
