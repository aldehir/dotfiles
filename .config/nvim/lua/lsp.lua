local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local lspconfig = require 'lspconfig'

cmp.setup({
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
--    ['<CR>'] = cmp.mapping.confirm({
--      behavior = cmp.ConfirmBehavior.Replace,
--      select = true,
--    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  experimental = {
    native_menu = false
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

require 'ltex'

local servers = { 'ansiblels', 'pyright', 'gopls', 'tsserver', 'svelte', 'ltex' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    ansible = {
      ansible = {
        useFullyQualifedCollectionNames = true
      }
    },
  }
end

lspconfig.efm.setup {
  init_options = {
    documentFormatting = true,
  },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      python = {
        { formatCommand = "black --quiet -", formatStdin = true },
        { formatCommand = "isort --quiet -", formatStdin = true },
      }
    }
  },
  on_attach = function(client, bufnr)
    opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ra', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>', opts)
  end
}

lspconfig.clangd.setup {
    cmd = { 'clangd', '--background-index', '--compile-commands-dir', '.', '--query-driver=/usr/bin/avr-gcc', },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
}

local signs = { Error = "", Warning = "", Hint = "", Information = "" }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = "",
    spacing = 4,
  },
  signs = true,
  underline = true,

  -- This might cause some performance problems??
  update_in_insert = true,
})

vim.cmd [[
autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})
]]
