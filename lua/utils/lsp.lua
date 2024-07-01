local M = {}

M.capabilities = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  return capabilities
end

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.on_attach = function(_, bufnr)
  local wc = require "which-key"

  wc.register {
    g = {
      name = "Go to",
      D = {
        buffer = bufnr,
        vim.lsp.buf.declaration,
        "Go to declaration",
      },
      d = {
        buffer = bufnr,
        vim.lsp.buf.definition,
        "Go to definition",
      },
      i = {
        buffer = bufnr,
        vim.lsp.buf.implementation,
        "Go to implementation",
      },
      l = {
        buffer = bufnr,
        function()
          vim.diagnostic.open_float { focus = false }
        end,
        "Get line diagnostic",
      },
    },
    ["<leader>"] = {
      sh = {
        buffer = bufnr,
        vim.lsp.buf.signature_help,
        "Show signature help",
      },
      wa = {
        buffer = bufnr,
        vim.lsp.buf.add_workspace_folder,
        "Add workspace folder",
      },
      wr = {
        buffer = bufnr,
        vim.lsp.buf.remove_workspace_folder,
        "Remove workspace folder",
      },
      wl = {
        buffer = bufnr,
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        "List workspace folders",
      },
      D = {
        buffer = bufnr,
        vim.lsp.buf.type_definition,
        "Go to type definition",
      },
      ra = {
        buffer = bufnr,
        function()
          print "TODO: Add lsp renaming function"
        end,
        "Rename files",
      },
    },
    ca = {
      buffer = bufnr,
      mode = { "n", "v" },
      vim.lsp.buf.code_action,
      "Code action",
    },
    gr = {
      buffer = bufnr,
      vim.lsp.buf.references,
      "Show references",
    },
  }
end

return M
