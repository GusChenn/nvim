return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "hrsh7th/nvim-cmp",
      {
        "stevearc/conform.nvim",
        event = "BufReadPre",
        opts = {
          formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier_d" },
            typescript = { "prettier_d" },
            javascriptreact = { "prettier_d" },
            typescriptreact = { "prettier_d" },
            ruby = { "rubocop" },
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
          },
        },
      },
      {
        "mfussenegger/nvim-lint",
        event = "BufReadPre",
        -- ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        config = function()
          local lint = require "lint"

          lint.linters_by_ft = {
            typescriptreact = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            javascript = { "eslint_d" },
            -- ruby = { "rubocop" },
          }
        end,

        init = function()
          vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
            callback = function()
              require("lint").try_lint()
            end,
          })
        end,
      },
    },
    config = function()
      local mason_lspconfig = require "mason-lspconfig"
      local lsp = require "utils.lsp"

      require("mason").setup()
      require("mason-lspconfig").setup()

      mason_lspconfig.setup {
        ensure_installed = require("general-opts").lsp.ensure_installed,
        automatic_installation = false,
      }

      local with_base_capabilities = function(extra_opts)
        local base_capabilities = {
          on_attach = lsp.on_attach,
          capabilities = lsp.capabilities(),
          on_init = lsp.on_init,
        }

        return vim.tbl_deep_extend("force", base_capabilities, extra_opts or {})
      end

      mason_lspconfig.setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup(with_base_capabilities())
        end,
        ["ts_ls"] = function()
          require("lspconfig").ts_ls.setup(with_base_capabilities {
            -- root_dir = vim.fs.dirname(vim.fs.find(".git", { path = startpath, upward = true })[1]),
            single_file_support = false,
          })
        end,
        ["eslint"] = function()
          require("lspconfig").eslint.setup(with_base_capabilities {
            on_attach = function(client, bufnr)
              lsp.on_attach(client, bufnr)

              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end,
            settings = {
              packageManager = "yarn",
            },
          })
        end,
        ["ruby_lsp"] = function()
          require("lspconfig").ruby_lsp.setup(with_base_capabilities {
            filetypes = { "ruby", "eruby" },
          })
        end,
        -- ["rubocop"] = function() end,
      }

      -- Customize diagnostics looks
      vim.diagnostic.config {
        virtual_text = {
          prefix = "",
          hl_mode = "combine",
          virt_text_pos = "eol",
          format = function(diagnostic)
            return "● " .. diagnostic.message
          end,
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          header = "  ᵈⁱᵃᵍⁿᵒˢᵗⁱᶜˢ",
          source = true,
          prefix = " ",
          border = "solid",
          suffix = "",
          format = function(diagnostic)
            return string.sub(diagnostic.message, 1, -2)
          end,
        },
      }
    end,
  },
  {
    -- TODO: Remove unecessary dependencies
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
      "brenoprata10/nvim-highlight-colors",
      -- Snippet engine
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
          -- lua format
          require("luasnip.loaders.from_lua").load()
          require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if
                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end,
          })

          require("luasnip").config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
          }
        end,
      },
    },
    config = function()
      local cmp = require "cmp"

      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
          { name = "lazydev", group_index = 0 },
        },
        window = {
          completion = {
            side_padding = 1,
            winhighlight = "Normal:MiniPickNormal,CursorLine:PmenuSel,Search:None",
            scrollbar = false,
            border = "solid",
          },
          documentation = {
            winhighlight = "Normal:MiniPickNormal",
            border = "solid",
          },
        },
        formatting = {
          -- format = require("lspkind").cmp_format {
          --   maxwidth = 50,
          --   ellipsis_char = "",
          -- },
          format = function(entry, item)
            local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
            item = require("lspkind").cmp_format {
              maxwidth = 50,
              ellipsis_char = "",
            }(entry, item)
            if color_item.abbr_hl_group then
              item.kind_hl_group = color_item.abbr_hl_group
              item.kind = color_item.abbr
            end
            return item
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-f>"] = cmp.mapping.scroll_docs(-4),
          ["<C-b>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-c>"] = cmp.mapping.close(),

          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
      }

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
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
    init = function()
      require("which-key").add {
        { "<leader>gD", require("garbage-day.utils").stop_lsp, desc = "Stop LSP servers" },
        { "<leader>ge", require("garbage-day.utils").start_lsp, desc = "Start LSP servers" },
      }
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    enabled = false, -- disabled since it doesnt work well with stayfi
    event = "VeryLazy",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {}, -- your configuration
  },
}
