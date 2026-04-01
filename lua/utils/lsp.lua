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
        -- If a hover window is already open, toggle focus
        local existing_win = vim.b[bufnr].hover_win
        if existing_win and vim.api.nvim_win_is_valid(existing_win) then
          if vim.api.nvim_get_current_win() == existing_win then
            -- Already focused on hover, go back to original buffer
            vim.cmd "wincmd p"
          else
            vim.api.nvim_set_current_win(existing_win)
          end
          return
        end

        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if #clients == 0 then return end
        local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding)

        vim.lsp.buf_request_all(0, "textDocument/hover", params, function(results)
          if not vim.api.nvim_buf_is_valid(bufnr) or vim.api.nvim_get_current_buf() ~= bufnr then
            return
          end

          -- Extract plain text from hover results (strip markdown fences)
          local lines = {}
          for _, resp in pairs(results) do
            if resp.result and resp.result.contents then
              local value = resp.result.contents.value or resp.result.contents
              if type(value) == "string" then
                for _, line in ipairs(vim.split(value, "\n", { trimempty = true })) do
                  if not line:match "^```" then
                    table.insert(lines, line)
                  end
                end
              end
            end
          end

          if #lines == 0 then
            vim.notify("No information available", vim.log.levels.INFO)
            return
          end

          local max_height = 5
          local truncated = #lines > max_height

          local hover_buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(hover_buf, 0, -1, false, lines)
          vim.bo[hover_buf].modifiable = false

          -- Show overflow indicator on the last visible line
          if truncated then
            local ns = vim.api.nvim_create_namespace "hover_overflow"
            vim.api.nvim_buf_set_extmark(hover_buf, ns, max_height - 1, 0, {
              virt_text = { { "   ", "DiagnosticInfo" } },
              virt_text_pos = "eol",
            })
          end

          -- Calculate width from content, capped at 80
          local width = 0
          for _, line in ipairs(lines) do
            width = math.max(width, vim.fn.strdisplaywidth(line))
          end
          width = math.min(width, 80)

          -- Open floating window anchored below the cursor
          local win = vim.api.nvim_open_win(hover_buf, false, {
            relative = "cursor",
            anchor = "NW",
            row = 1,
            col = 0,
            width = width,
            height = math.min(#lines, max_height),
            style = "minimal",
            border = "solid",
          })

          -- Store reference so second K press can focus it
          vim.b[bufnr].hover_win = win

          -- Map q to close and K to jump back when focused
          local function close_hover()
            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(hover_buf) then
              vim.api.nvim_buf_delete(hover_buf, { force = true })
            end
            vim.b[bufnr].hover_win = nil
          end

          vim.api.nvim_buf_set_keymap(hover_buf, "n", "q", "", {
            noremap = true,
            silent = true,
            callback = close_hover,
          })

          vim.api.nvim_buf_set_keymap(hover_buf, "n", "K", "", {
            noremap = true,
            silent = true,
            callback = function()
              vim.cmd "wincmd p"
            end,
          })

          -- Close on cursor move in the original buffer
          local augroup = vim.api.nvim_create_augroup("hover_close_" .. win, { clear = true })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertCharPre" }, {
            group = augroup,
            buffer = bufnr,
            once = true,
            callback = function()
              if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
              end
              if vim.api.nvim_buf_is_valid(hover_buf) then
                vim.api.nvim_buf_delete(hover_buf, { force = true })
              end
              vim.b[bufnr].hover_win = nil
            end,
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
