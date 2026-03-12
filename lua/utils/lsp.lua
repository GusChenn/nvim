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

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- if client.supports_method "textDocument/hover" then
  --   local orig_hover = vim.lsp.handlers.hover
  --
  --   vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  --     config = config or {}
  --     config.border = config.border or "rounded"
  --
  --     -- Convert hover contents to markdown lines
  --     local lines = {}
  --     if result and result.contents then
  --       lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  --       lines = vim.lsp.util.trim_empty_lines(lines)
  --     end
  --     if vim.tbl_isempty(lines) then
  --       return
  --     end
  --
  --     -- 1-cell horizontal + vertical padding
  --     local padded = { "" } -- top padding
  --     for _, line in ipairs(lines) do
  --       table.insert(padded, " " .. line .. " ")
  --     end
  --     table.insert(padded, "") -- bottom padding
  --
  --     local width = 0
  --     for _, line in ipairs(padded) do
  --       width = math.max(width, vim.fn.strdisplaywidth(line))
  --     end
  --
  --     return vim.lsp.util.open_floating_preview(padded, "markdown", {
  --       border = config.border,
  --       max_width = config.max_width,
  --       max_height = config.max_height,
  --       focusable = config.focusable ~= false,
  --       focus_id = config.focus_id,
  --       pad_left = 0,
  --       pad_right = 0,
  --       width = width,
  --     })
  --   end
  -- end
end

M.on_attach = function(_, bufnr)
  local wc = require "which-key"

  wc.add {
    {
      "gD",
      buffer = bufnr,
      vim.lsp.buf.declaration,
      desc = "Go to declaration",
    },
    {
      "gd",
      buffer = bufnr,
      vim.lsp.buf.definition,
      desc = "Go to definition",
    },
    {
      "gi",
      buffer = bufnr,
      vim.lsp.buf.implementation,
      desc = "Go to implementation",
    },
    {
      "gl",
      buffer = bufnr,
      function()
        vim.diagnostic.open_float { focus = false }
      end,
      desc = "Get line diagnostic",
    },
    {
      "<leader>sh",
      buffer = bufnr,
      vim.lsp.buf.signature_help,
      desc = "Show signature help",
    },
    {
      "<leader>wa",
      buffer = bufnr,
      vim.lsp.buf.add_workspace_folder,
      desc = "Add workspace folder",
    },
    {
      "<leader>wr",
      buffer = bufnr,
      vim.lsp.buf.remove_workspace_folder,
      desc = "Remove workspace folder",
    },
    {
      "<leader>wl",
      buffer = bufnr,
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = "List workspace folders",
    },
    {
      "<leader>D",
      buffer = bufnr,
      vim.lsp.buf.type_definition,
      desc = "Go to type definition",
    },
    {
      "<leader>ra",
      buffer = bufnr,
      function()
        print "TODO: Add lsp renaming function"
      end,
      desc = "Rename files",
    },
    {
      "ca",
      buffer = bufnr,
      vim.lsp.buf.code_action, -- default code actions
      -- require("fastaction").code_action,
      -- desc = "Code action",
      -- mode = { "n", "v" },
    },
    {
      "gr",
      buffer = bufnr,
      vim.lsp.buf.references,
      desc = "Show references",
    },
  }
end

M.python_project_root_path = function()
  return vim.fs.root(vim.fs.joinpath(vim.env.PWD, "main.py"), { "pyproject.toml", "setup.py" })
end

M.ruby_project_root_path = function()
  return vim.fs.root(vim.fs.joinpath(vim.env.PWD, "Gemfile"), { "Gemfile.lock", "Rakefile" })
end

return M
