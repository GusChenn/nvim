vim.diagnostic.config({
  float = {
    border = "solid",
    source = true,
    header = "",
    prefix = "-",
  }
})

vim.o.winborder = "solid"

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp.mappings', {}),

  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
    end

    if client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
    end

    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
    end

    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
    end

    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { desc = 'Code action' })
    end

    vim.keymap.set('n', 'gl', function()
      vim.diagnostic.open_float { focus = false }
    end, {})
  end,
})

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig'
})

vim.lsp.enable({ 'lua_ls', 'ruby_lsp', 'ts_ls' })
