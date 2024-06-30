return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local mason_lspconfig = require "mason-lspconfig"

      require("mason").setup()
      require("mason-lspconfig").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()

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

      local on_init = function(client, _)
        if client.supports_method "textDocument/semanticTokens" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end

      local on_attach = function(_, bufnr)
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

      mason_lspconfig.setup {
        ensure_installed = require("general-opts").lsp.ensure_installed,
        automatic_installation = false,
      }

      local with_base_capabilities = function(extra_opts)
        local base_capabilities = {
          on_attach = on_attach,
          capabilities = capabilities,
          on_init = on_init,
        }

        return vim.tbl_deep_extend("force", base_capabilities, extra_opts or {})
      end

      mason_lspconfig.setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup(with_base_capabilities())
        end,
        ["tsserver"] = function()
          require("lspconfig").tsserver.setup(with_base_capabilities {
            root_dir = require("lspconfig.util").find_git_ancestor,
            single_file_support = false,
          })
        end,
        ["eslint"] = function(client, bufnr)
          require("lspconfig").tsserver.setup(with_base_capabilities {
            settings = {
              packageManager = "yarn",
            },
            on_attach = function()
              on_attach(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end,
          })
        end,
      }

      -- Customize diagnostics looks
      vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   opts = function()
  --     return require "configs.cmp"
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require "configs.none_ls"
  --   end,
  -- },
  {
    "zeioth/garbage-day.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      grace_perios = 60 * 10,
      notifications = false,
      retries = 3,
      timeout = 1000,
    },
  },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    cmd = "Spectre",
    config = true,
  },
}
