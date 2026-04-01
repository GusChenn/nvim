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
end

M.on_attach = function(_, bufnr)
  local wc = require "which-key"

  wc.add {
    {
      "K",
      buffer = bufnr,
      function()
        local max_width = 80
        local params = vim.lsp.util.make_position_params()

        vim.lsp.buf_request_all(0, "textDocument/hover", params, function(results)
          if not vim.api.nvim_buf_is_valid(bufnr) or vim.api.nvim_get_current_buf() ~= bufnr then
            return
          end

          local contents = {}
          for _, resp in pairs(results) do
            if resp.result and resp.result.contents then
              vim.list_extend(contents, vim.lsp.util.convert_input_to_markdown_lines(resp.result.contents))
            end
          end

          contents = vim.lsp.util.trim_empty_lines(contents)
          if vim.tbl_isempty(contents) then
            vim.notify("No information available", vim.log.levels.INFO)
            return
          end

          -- Calculate wrapped height: how many display rows each line needs at max_width
          local height = 0
          for _, line in ipairs(contents) do
            local w = vim.fn.strdisplaywidth(line)
            height = height + math.max(1, math.ceil(w / max_width))
          end

          vim.lsp.util.open_floating_preview(contents, "markdown", {
            max_width = max_width,
            height = math.min(height, 40),
            focus_id = "textDocument/hover",
          })
        end)
      end,
      desc = "Hover documentation",
    },
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
