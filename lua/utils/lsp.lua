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

  client.offset_encoding = "utf-8"
end

M.on_attach = function(_, bufnr)
  local wc = require "which-key"

  wc.add {
    { "gD",         buffer = bufnr, vim.lsp.buf.declaration,                                                 desc = "Go to declaration", },
    { "gd",         buffer = bufnr, vim.lsp.buf.definition,                                                  desc = "Go to definition", },
    { "gi",         buffer = bufnr, vim.lsp.buf.implementation,                                              desc = "Go to implementation", },
    { "gl",         buffer = bufnr, function() vim.diagnostic.open_float { focus = false } end,              desc = "Get line diagnostic", },
    { "<leader>sh", buffer = bufnr, vim.lsp.buf.signature_help,                                              desc = "Show signature help", },
    { "<leader>wa", buffer = bufnr, vim.lsp.buf.add_workspace_folder,                                        desc = "Add workspace folder", },
    { "<leader>wr", buffer = bufnr, vim.lsp.buf.remove_workspace_folder,                                     desc = "Remove workspace folder", },
    { "<leader>wl", buffer = bufnr, function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List workspace folders", },
    { "<leader>D",  buffer = bufnr, vim.lsp.buf.type_definition,                                             desc = "Go to type definition", },
    { "<leader>ra", buffer = bufnr, function() print "TODO: Add lsp renaming function" end,                  desc = "Rename files", },
    { "ca",         buffer = bufnr, vim.lsp.buf.code_action,                                                 desc = "Code action",             mode = { "n", "v" }, },
    { "gr",         buffer = bufnr, vim.lsp.buf.references,                                                  desc = "Show references", },
  }
end

return M
