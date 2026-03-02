return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    opts = {
      scope = "git_branch",
      style = "relative",
      win_opts = {
        border = "solid",
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>p", cmd "Grapple toggle_tags", desc = "Toggle grapple window" },
        { "<leader>pp", cmd "Grapple tag", desc = "Tag current window" },
        { "<leader>l", cmd "Grapple cycle_tags next", desc = "Grapple cycle to next tag" },
        { "<leader>h", cmd "Grapple cycle_tags prev", desc = "Grapple cycle to previous tag" },
      }
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      -- Disable copilot on org roam search buffers
      vim.g.copilot_filetypes = {
        ["org-roam-select"] = false,
      }

      vim.keymap.set("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })
      vim.g.copilot_no_tab_map = true

      require("which-key").add {
        { "<leader>cd", cmd "Copilot disable", desc = "Disable copilot virtual text" },
        { "<leader>ce", cmd "Copilot enable", desc = "Enable copilot virtual text" },
      }
    end,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>rv", cmd "Eview", desc = "Edit view" },
        { "<leader>rc", cmd "Econtroller", desc = "Edit controller" },
        { "<leader>to", "a<%=  %><ESC>3ha", desc = "Create a rails view tag" },
        { "<leader>te", "a<% end %><ESC>", desc = "Create a end rails view tag" },
      }
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "folke/snacks.nvim",
      "ravitemer/mcphub.nvim",
      "banjo/contextfiles.nvim",
      "ravitemer/codecompanion-history.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      "OXY2DEV/markview.nvim",
    },
    lazy = false,
    opts = function()
      return {
        ignore_warnings = true,
        strategies = {
          chat = {
            adapter = "copilot",
            roles = {
              llm = function(adapter)
                return string.format(
                  "  %s%s",
                  adapter.formatted_name,
                  " (" .. (adapter.schema.model.default or "unknown") .. ")"
                )
              end,
              user = "  GusChenn",
            },
            slash_commands = {
              ["file"] = {
                opts = {
                  provider = "snacks", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  contains_code = true,
                },
              },
            },
          },
          inline = {
            adapter = "copilot",
            keymaps = {
              accept_change = {
                modes = { n = "ga" },
                description = "Accept the suggested change",
              },
              reject_change = {
                modes = { n = "gr" },
                description = "Reject the suggested change",
              },
            },
          },
        },
        display = {
          chat = {
            icons = {
              buffer_pin = "󰐃  ",
              buffer_watch = "󰈈  ",
            },
            window = {
              position = "right",
              border = "single",
              opts = {
                cursorline = true,
              },
              show_header_separator = false,
              separator = "",
            },
          },
          action_palette = {
            provider = "snacks",
          },
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              auto_save = true,
              expiration_days = 10,
              picker = "snacks",
              auto_generate_title = true,
              title_generation_opts = {
                adapter = nil,
                model = nil,
              },
              continue_last_chat = false,
              delete_on_clearing_chat = false,
              dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
              enable_logging = false,
            },
          },
          spinner = {},
        },
        interactions = {
          chat = {
            adapter = "copilot",
            model = "gemini-3-pro-preview",
          },
          inline = {
            adapter = "copilot",
          },
          cmd = {
            adapter = "copilot",
          },
        },
        adapters = {
          http = {
            copilot = function()
              return require("codecompanion.adapters").extend("copilot", {
                schema = {
                  model = {
                    default = "gpt-5.3-codex",
                  },
                },
              })
            end,
          },
        },
      }
    end,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<A-T>", cmd "CodeCompanionChat Toggle", mode = { "n", "v" }, desc = "Toggle codecompanion chat" },
        { "<leader>ai", cmd "CodeCompanion", mode = { "n", "v" }, desc = "Inline codecompanion prompt" },
        -- Commented out because im using a custom picker. Check my snacks config
        -- { "<leader>aa", cmd "CodeCompanionActions", mode = { "n", "v" }, desc = "Open codecompanion actions" },
        { "<C-s>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Accept next word of copilot suggestion" },
      }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
  },
  {
    "folke/sidekick.nvim",
    lazy = false,
    opts = {
      nes = { enabled = false },
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<C-a>",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      -- Commented out because im using a custom picker. Check my snacks config
      -- {
      --   "<leader>aa",
      --   function()
      --     require("sidekick.cli").toggle()
      --   end,
      --   desc = "Sidekick Toggle CLI",
      -- },
      {
        "<leader>sf",
        function()
          require("sidekick.cli").send { msg = "{file}" }
        end,
        desc = "Send File",
      },
      {
        "<leader>sv",
        function()
          require("sidekick.cli").send { msg = "{selection}" }
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
    },
  },
}
