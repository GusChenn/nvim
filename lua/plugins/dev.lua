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
    "ldelossa/gh.nvim",
    cmd = "GHOpenPR",
    dependencies = {
      {
        "ldelossa/litee.nvim",
        cmd = "GHOpenPR",
        config = function()
          require("litee.lib").setup {
            tree = {
              icon_set = "codicons",
              icon_set_custom = {
                Collapsed = " ",
                Expanded = "",
                IndentGuide = " ",
              },
            },
          }
        end,
      },
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("litee.gh").setup {
        icon_set = "codicons",
      }
    end,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>ghpo", cmd "GHOpenPR", desc = "Open a GH PR" },
        { "<leader>ghpc", cmd "GHClosePR", desc = "Close a GH PR" },
        { "<leader>ghtc", cmd "GHCreateThread", desc = "Start a GH thread" },
        { "<leader>ghtt", cmd "GHToggleThreads", desc = "Toggle a thread" },
        { "<leader>ghrc", cmd "GHStartReview", desc = "Start a GH review" },
        { "<leader>ghrs", cmd "GHSubmitReview", desc = "Submit a GH review" },
        { "<leader>ghe", cmd "LTPanel", desc = "Toggle litee panel" },
      }
    end,
  },
  {
    "grzegorzszczepanek/gamify.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
