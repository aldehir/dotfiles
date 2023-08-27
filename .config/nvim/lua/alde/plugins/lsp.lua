return function(lazyplugin, lazyopts)
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
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.confirm()
        elseif luasnip.expandable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand', true, true, true), '')
        else
          fallback()
        end
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      -- { name = 'path' },
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

  local capabilities = cmp_nvim_lsp.default_capabilities()

  local on_attach = function(client, bufnr)
    local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  end

  local servers = { 'pyright', 'ansiblels', 'zls', 'tsserver', 'svelte' }
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
  end

  function goimports(timeout_ms)
    local client_id = nil

    for _, client in pairs(vim.lsp.get_active_clients()) do
      if client.name == "gopls" then
        client_id = client.id
      end
    end

    if not client_id then
      return
    end

    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or result[client_id] == nil then return end

    local actions = result[client_id].result
    if not actions then return end
    local action = actions[1]

    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end

  -- _G.gofmt = function(timeout_ms)
  --   goimports(timeout_ms)
  --   vim.lsp.buf.formatting_sync(nil, timeout_ms)
  -- end
  -- 
  -- _G.goimports = goimports

  -- vim.cmd [[
  -- autocmd BufWritePre *.go lua gofmt(1000)
  -- ]]

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

  -- Uncomment to show documentation when over a word
  --
  -- vim.cmd [[
  -- autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float()
  -- ]]

  require("go").setup({
    lsp_cfg = true,
  })

  local format_snyc_grp = vim.api.nvim_create_augroup("GoFormat", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require("go.format").goimport()
    end,
    group = format_snyc_grp,
  })
end
