local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup()

lsp.ensure_installed({
  'tsserver',
  'eslint',
  -- 'sumneko_lua',
  'lua_ls',
})

-- Publish the lsp diagnostics virtually, meaning on the line where the issue exists
-- https://github.com/folke/trouble.nvim/issues/171#issuecomment-1356622735
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  local wrap = function(func)
    local opts = {
      symbols = {
        "function",
        "method"
      }
    }
    return function()
      func(opts)
    end
  end
  -- https://github.com/nvim-telescope/telescope.nvim/issues/837#issuecomment-1093782003
  vim.keymap.set('n', '<leader>o', wrap(require('telescope.builtin').lsp_document_symbols), { desc = '[O] Document Functions' })


  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gk', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- nmap('<C-K>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- nmap('<M-K>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

-- if client.server.capabilities.documentHighlightProvider then


  local cursorhighlight_group = vim.api.nvim_create_augroup('CursorHighlight', { clear = true })
  vim.api.nvim_create_autocmd('CursorHold', {
    -- callback = function()
    --   vim.lsp.buf.document_highlight()
    -- end,
    callback = function(args)
      local all_clients = vim.lsp.get_active_clients()
      print('aaaaaa')
      for i, val in pairs(all_clients) do
        if val.server_capabilities.documentHighlightProvider then
          print("True!")
          vim.lsp.buf.document_highlight()
        end
      end
    end,
    group = cursorhighlight_group,
    pattern = '<buffer>',
  })
  vim.api.nvim_create_autocmd('CursorHoldI', {
    -- callback = function()
    --   vim.lsp.buf.document_highlight()
    -- end,
    callback = function(args)
      local all_clients = vim.lsp.get_active_clients()
      -- print('aaaaaa')
      for i, val in pairs(all_clients) do
        if val.server_capabilities.documentHighlightProvider then
          print("True!")
          vim.lsp.buf.document_highlight()
        end
      end
    end,
    group = cursorhighlight_group,
    pattern = '<buffer>',
  })

  vim.api.nvim_create_autocmd('CursorMoved', {
    callback = function()
      vim.lsp.buf.clear_references()
    end,
    group = cursorhighlight_group,
    pattern = '<buffer>',
  })

-- end
  -- print(vim.inspect(client))
  -- print(vim.inspect(client.server_capabilities))

  -- print(vim.inspect(client.server_capabilities.documentHighlightProvider))

  -- if  client.server_capabilities.documentHighlightProvider then
  --   vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
  --   vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
  --   vim.api.nvim_create_autocmd("CursorHold", {
  --     callback = vim.lsp.buf.document_highlight,
  --     -- callback = function(args)
  --     --   local client2 = vim.lsp.get_client_by_id(args.data.client_id)
  --     --   print(vim.inspect(client2.server_capabilities))
  --     --   if client.server_capabilities.documentHighlightProvider then
  --     --     vim.lsp.buf.document_highlight()
  --     --   end
  --     -- end,
  --     buffer = bufnr,
  --     group = "lsp_document_highlight",
  --     desc = "Document Highlight",
  --   })
  --   vim.api.nvim_create_autocmd("CursorMoved", {
  --     callback = vim.lsp.buf.clear_references,
  --     buffer = bufnr,
  --     group = "lsp_document_highlight",
  --     desc = "Clear All the References",
  --   })
  -- end

end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- This is required to happen after the mason setup
require('mason-nvim-dap').setup({
  automatic_setup = true
})

require('mason-nvim-dap').setup_handlers()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['C-p'] = cmp.mapping.select_prev_item(cmp_select),
    ['C-n'] = cmp.mapping.select_next_item(cmp_select),
    ['C-y'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

