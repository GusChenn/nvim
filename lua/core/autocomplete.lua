local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = require("core.helpers.map")

autocmd('LspAttach', {
  group = augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/implementation') then
      map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
    end

    if client:supports_method('textDocument/definition') then
      map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
    end

    if client:supports_method('textDocument/declaration') then
      map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
    end

    if client:supports_method('textDocument/references') then
      map('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
    end

    if client:supports_method('textDocument/hover') then
      map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
    end

    if client:supports_method('textDocument/codeAction') then
      map('n', 'ca', vim.lsp.buf.code_action, { desc = 'Code action' })
    end

    map('n', 'gl', function()
      vim.diagnostic.open_float { focus = false }
    end, {})

    if client:supports_method('textDocument/completion') then
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

vim.opt.complete:append('o')
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.o.pumheight = 8
vim.o.pumborder = 'single'
vim.o.pummaxwidth = 20
