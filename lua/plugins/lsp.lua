return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/nvim-cmp",
      {
        "stevearc/conform.nvim",
        event = "BufReadPre",
        opts = function()
          local function safe_use_project_ruff()
            local python_project_root = require("utils.lsp").python_project_root_path()

            if not python_project_root then
              require("conform.log").error "Ruff formatter: no Python project root found. Please ensure you are in a Python project."

              return {
                command = "ruff",
              }
            end

            local ruff_bin_path = require("utils.lsp").python_project_root_path() .. "/.venv/bin/ruff"

            if vim.fn.executable(ruff_bin_path) == 1 then
              return {
                command = require("conform.util").find_executable({ ruff_bin_path }, "ruff"),
              }
            else
              require("conform.log").error "Ruff formatter: no bin installed in this project. Please install it (uv init; uv add --dev ruff)"

              return {
                command = "ruff",
              }
            end
          end

          local function safe_use_project_rubocop()
            local ruby_project_root = require("utils.lsp").ruby_project_root_path()

            if not ruby_project_root then
              require("conform.log").error "Rubocop formatter: no Ruby project root found. Please ensure you are in a Ruby project."

              return {
                command = "rubocop",
              }
            end

            local rubocop_bin_path = require("utils.lsp").ruby_project_root_path() .. "/bin/rubocop"

            if vim.fn.executable(rubocop_bin_path) == 1 then
              return {
                command = require("conform.util").find_executable({ rubocop_bin_path }, "rubocop"),
              }
            else
              require("conform.log").error "Rubocop formatter: no bin installed in this project. Please install it (gem install rubocop)"

              return {
                command = "rubocop",
              }
            end
          end

          return {
            log_level = vim.log.levels.DEBUG,
            formatters = {
              rubocop = safe_use_project_rubocop(),
              ruff_format = safe_use_project_ruff(),
              ruff_fix = safe_use_project_ruff(),
              ruff_organize_imports = safe_use_project_ruff(),
            },
            formatters_by_ft = {
              lua = { "stylua" },
              javascript = { "eslint_d" },
              typescript = { "eslint_d" },
              javascriptreact = { "eslint_d" },
              typescriptreact = { "eslint_d" },
              ruby = { "rubocop" },
              python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            },
            format_on_save = {
              timeout_ms = 2000,
              lsp_format = "never",
              -- async = true,
              stop_after_first = true,
            },
          }
        end,
      },
      -- {
      --   "mfussenegger/nvim-lint",
      --   enabled = false,
      --   event = "BufReadPre",
      --   config = function()
      --     local lint = require "lint"
      --
      --     lint.linters_by_ft = {
      --       -- typescriptreact = { "eslintd" },
      --       -- typescript = { "eslintd" },
      --       -- javascriptreact = { "eslintd" },
      --       -- javascript = { "eslint_d" },
      --       -- javascript = { "eslint" },
      --       -- javascript = { "local_eslint" },
      --       -- ruby = { "rubocop" },
      --     }
      --   end,
      --
      --   init = function()
      --     vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
      --       callback = function()
      --         require("lint").try_lint()
      --       end,
      --     })
      --   end,
      -- },
    },
    config = function()
      local lsp = require "utils.lsp"

      local function safe_load_ruff_lsp()
        local python_root = lsp.python_project_root_path()
        local ruff_cmd

        if python_root then
          ruff_cmd = { python_root .. "/.venv/bin/ruff", "server" }
        else
          ruff_cmd = { "ruff", "server" } -- Fallback for non-python projects
        end

        return ruff_cmd
      end

      vim.lsp.config["ruby_lsp"] = {
        cmd = { "ruby-lsp" },
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities(),
        on_init = lsp.on_init,
      }

      vim.lsp.config["eslint"] = {
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities(),
        on_init = lsp.on_init,
      }

      -- npm install -g typescript typescript-language-server
      -- Couldnt figure out how to target project specific tsserver
      vim.lsp.config["ts_ls"] = {
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities(),
        on_init = lsp.on_init,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      }

      -- npm i -g vscode-langservers-extracted
      -- Couldnt figure out how to target project specific cssls
      vim.lsp.config["css_ls"] = {
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities(),
        on_init = lsp.on_init,
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        root_markers = { "package.json", ".git" },
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      }

      -- npm i -g vscode-langservers-extracted
      -- Couldnt figure out how to target project specific htmlls
      vim.lsp.config["html"] = {
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities(),
        on_init = lsp.on_init,
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html", "templ" },
        root_markers = { "package.json", ".git" },
        settings = {},
        init_options = {
          provideFormatter = true,
          embeddedLanguages = { css = true, javascript = true },
          configurationSection = { "html", "css", "javascript" },
        },
      }

      vim.lsp.config["lua_ls"] = {
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities(),
        on_init = function(client, bufnr)
          lsp.on_init(client, bufnr)

          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath "config"
              and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using (most
              -- likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = {
                "lua/?.lua",
                "lua/?/init.lua",
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths
                -- here.
                -- '${3rd}/luv/library'
                -- '${3rd}/busted/library'
              },
              -- Or pull in all of 'runtimepath'.
              -- NOTE: this is a lot slower and will cause issues when working on
              -- your own configuration.
              -- See https://github.com/neovim/nvim-lspconfig/issues/3189
              -- library = {
              --   vim.api.nvim_get_runtime_file('', true),
              -- }
            },
          })
        end,
        settings = {
          Lua = {},
        },
      }

      vim.lsp.config["ruff"] = {
        init_options = {
          settings = {
            args = {},
          },
        },
        cmd = safe_load_ruff_lsp(),
        filetypes = { "python" },
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities(),
        on_init = lsp.on_init,
      }

      vim.lsp.enable {
        "ruby_lsp",
        "eslint",
        "ts_ls",
        "css_ls",
        "html",
        "lua_ls",
        "ruff",
      }

      -- Customize diagnostics looks
      vim.diagnostic.config {
        virtual_text = false,
        undercurl = true,
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
        init = function()
          -- Declare custom snippets
          local ls = require "luasnip"
          local s = ls.snippet
          local i = ls.insert_node
          local t = ls.text_node

          ls.add_snippets("org", {
            s("src", {
              t("#+BEGIN_SRC "), i(1, "language"), t { "", "" }, i(0), t { "", "#+END_SRC" },
            }),
          })

          ls.add_snippets("eruby", {
            s("<% block", {
              t("<% "), i(1, "code"), t { " %>" }, i(0), t { "", "" }, t("<% end %>"),
            }),
            s("<%= block", {
              t("<%= "), i(1, "code"), t { " %>" }, i(0), t { "", "" }, t("<% end %>"),
            }),
            s("<%=", {
              t("<%= "), i(1, "code"), t { " %>" },
            }),
          })

          -- Set keymaps for navigating placeholder values in snippets
          local wk = require "which-key"

          wk.add {
            {
              "<C-k>",
              function()
                if ls.expand_or_jumpable() then ls.expand_or_jump() end
              end,
              desc = "Expand or jump in snippet"
            },
            {
              "<C-j>",
              function()
                if ls.jumpable(-1) then ls.jump(-1) end
              end,
              desc = "Jump backwards in snippet",
            }
          }
        end
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
          { name = "orgmonde" },
        },
        window = {
          completion = {
            side_padding = 1,
            winhighlight = "Normal:MiniPickNormal,CursorLine:PmenuSel,Search:None",
            scrollbar = false,
            border = "single",
          },
          documentation = {
            winhighlight = "Normal:MiniPickNormal,CursorLine:PmenuSel,Search:None",
            border = "single",
          },
        },
        formatting = {
          format = require("lspkind").cmp_format {
            maxwidth = 50,
            ellipsis_char = "",
          },
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

      -- Disable cmp in org-roam-select filetype since it messes up selection
      cmp.setup.filetype({ 'org-roam-select'}, {
        enabled = false
      })
    end,
  },
  {
    "zeioth/garbage-day.nvim",
    enabled = false,
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
