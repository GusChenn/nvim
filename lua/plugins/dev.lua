return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require "config.long-configs.nvim-tree",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").register({
        e = { cmd "NvimTreeToggle", "Toggle explorer" },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "UIEnter" },
    config = function()
      require("illuminate").configure {
        modes_denylist = {
          "i",
          "ic",
          "ix",
        },
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
          "copilot-chat",
          "NvimTree",
        },
        providers = {
          "regex",
          "treesitter",
          "lsp",
        },
        min_count_to_highlight = 2,
      }
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "UIEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = require "config.long-configs.nvim-ufo",
    init = function()
      require("which-key").register({
        p = { "za", "Toggle fold (za)" },
      }, { prefix = "f" })
    end,
  },
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    opts = {
      scope = "git_branch",
      style = "basename",
      win_opts = {
        border = "solid",
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").register({
        p = {
          cmd "Grapple toggle_tags",
          "Toggle grapple window",
          p = {
            cmd "Grapple tag",
            "Tag current window",
          },
        },
        l = { cmd "Grapple cycle_tags next", "Grapple cycle to next tag" },
        h = { cmd "Grapple cycle_tags prev", "Grapple cycle to previous tag" },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "UIEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = require "config.long-configs.nvim-ufo",
    init = function()
      require("which-key").register({
        p = { "za", "Toggle fold (za)" },
      }, { prefix = "f" })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    event = "VeryLazy",
    config = function()
      require("telescope").setup(require "config.long-configs.telescope")
    end,
    init = function()
      local telescope = require "telescope"

      telescope.load_extension "fzf"
      telescope.load_extension "undo"
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    {
      "RRethy/nvim-treesitter-endwise",
      event = "BufEnter",
      dependencies = {
        "nvim-treesitter",
      },
    },
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").register({
        c = {
          d = {
            cmd "Copilot disable",
            "Disable copilot virtual text",
          },
          e = {
            cmd "Copilot enable",
            "Enable copilot virtual text",
          },
        },
      }, { prefix = "<leader>" })
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
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      context = "buffers",

      question_header = "󰙊 ",
      answer_header = " ",
      error_header = " ",
      separator = " ",

      show_help = false,
      show_folds = false,
      auto_follow_cursor = false,

      callback = function()
        vim.cmd("CopilotChatSave " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
      end,

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

      require("which-key").register({
        c = {
          m = {
            require("utils.ai.ai-helpers").commit_with_ai,
            "Generate commit message with ai",
          },
          t = {
            mode = "v",
            cmd "CopilotChatTest",
            "Generate test with ai",
          },
        },
      }, { prefix = "<leader>" })

      require("which-key").register {
        ["<A-T>"] = {
          mode = { "n", "v" },
          require("utils.ai.ai-helpers").toggle_copilot_chat,
          "Toggle copilot chat",
        },
        ["<A-E>"] = {
          mode = "v",
          cmd "CopilotChatExplain",
          "Explain selection with ai",
        },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "tsx", "html" },
    config = true,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
          label = {
            style = "overlay",
          },
        },
        char = {
          enabled = false,
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
