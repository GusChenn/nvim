local helpers = require('user.helpers')
local null_ls = helpers.SafeRequire('null-ls')

if null_ls then
  local formatting = null_ls.builtins.formatting
  -- local code_actions = null_ls.builtins.code_actions
  local diagnostics = null_ls.builtins.diagnostics

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
      bufnr = bufnr,
    })
  end

  null_ls.setup {
    sources = {
      -- code_actions.eslint,
      formatting.prettierd,
      diagnostics.eslint_d,
      -- code_actions.eslint_d,
      -- null_ls.builtins.completion.spell,
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end
        })
      end
    end,
  }
end
