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
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>cd", cmd "Copilot disable", desc = "Disable copilot virtual text" },
        { "<leader>ce", cmd "Copilot enable", desc = "Enable copilot virtual text" },
      }
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false, -- disabled because im trying codecompanion
    cmd = {
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatTest",
      "CopilotChatCommitStaged",
      "CopilotChatLoad",
      "CopilotChatFixDiagnostic",
    },
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      model = "claude-3.5-sonnet",
      window = {
        -- layout = "float",
        width = 0.33,
        height = 1,
        relative = "editor",
        col = 9999,
        title = "  Copilot Chat",
        border = "solid",
      },

      context = "buffers",

      question_header = "󰙊 ",
      answer_header = " ",
      error_header = " ",
      separator = " ",

      show_help = false,
      show_folds = false,
      auto_follow_cursor = false,

      mappings = {
        reset = {
          normal = "<leader><C-l>",
        },
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<S-Tab>",
        },
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>cm", require("utils.ai.ai-helpers").commit_with_ai, desc = "Generate commit message with ai" },
        {
          "<leader>ct",
          cmd "CopilotChatTest",
          mode = "v",
          desc = "Generate test with ai",
        },
        {
          "<A-T>",
          cmd "CopilotChatToggle",
          mode = { "n", "v" },
          desc = "Toggle copilot chat",
        },
        {
          "<A-E>",
          cmd "CopilotChatExplain",
          mode = "v",
          desc = "Explain selection with ai",
        },
      }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    cmd = "Spectre",
    opts = {
      find_engine = {
        ["rg"] = {
          args = {
            "--pcre2",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
        },
      },
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = {
            "-i",
            "-E",
          },
        },
      },
    },
    init = function()
      require("which-key").add {
        { "<A-F>", require("spectre").toggle, desc = "Toggle Spectre" },
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
      }
    end,
  },
  {
    "grzegorzszczepanek/gamify.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "yetone/avante.nvim",
    enabled = false, -- disabled because im trying codecompanion
    event = "VeryLazy",
    lazy = false,
    version = "*",
    opts = {
      provider = "copilot",
      windows = {
        sidebar_header = {
          rounded = false,
        },
        input = {
          prefix = "󰏫 ",
        },
        edit = {
          border = "single",
        },
        ask = {
          border = "single",
          start_insert = false,
        },
      },
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<A-T>", cmd "AvanteChat", desc = "Open avante chat" },
      }
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            llm = " ",
            -- user = " ", -- commented out because enabling this causes the chat to not work for some reason
          },
          slash_commands = {
            ["file"] = {
              opts = {
                provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
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
            pinned_buffer = "󰏫 ",
            watched_buffer = "watch",
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
          provider = "telescope",
        },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                -- default = "claude-3.5-sonnet",
                default = "o3-mini-2025-01-31",
              },
            },
          })
        end,
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        {
          "<A-T>",
          cmd "CodeCompanionChat Toggle",
          mode = { "n", "v" },
          desc = "Toggle codecompanion chat",
        },
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
}
