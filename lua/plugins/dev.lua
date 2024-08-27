return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require "config.long-configs.nvim-tree",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add({
        { "<leader>e", cmd "NvimTreeToggle", desc = "Toggle explorer" },
      })
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

      require("which-key").add({
        { "<leader>p",  cmd "Grapple toggle_tags",     desc = "Toggle grapple window", },
        { "<leader>pp", cmd "Grapple tag",             desc = "Tag current window", },
        { "<leader>l",  cmd "Grapple cycle_tags next", desc = "Grapple cycle to next tag" },
        { "<leader>h",  cmd "Grapple cycle_tags prev", desc = "Grapple cycle to previous tag" },
      })
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
      require("which-key").add({
        { "fp", "za", desc = "Toggle fold (za)" },
      })
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
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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

      require("which-key").add({
        { "<leader>cd", cmd "Copilot disable", desc = "Disable copilot virtual text", },
        { "<leader>ce", cmd "Copilot enable",  desc = "Enable copilot virtual text", },
      })
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
      window = {
        layout = "float",
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

      require("which-key").add({
        { "<leader>cm", require("utils.ai.ai-helpers").commit_with_ai, desc = "Generate commit message with ai", },
        { "<leader>ct", cmd "CopilotChatTest",                         mode = "v",                               desc = "Generate test with ai", },
      })

      require("which-key").add {
        { "<A-T>", require("utils.ai.ai-helpers").toggle_copilot_chat, mode = { "n", "v" }, desc = "Toggle copilot chat", },
        { "<A-E>", cmd "CopilotChatExplain",                           mode = "v",          desc = "Explain selection with ai", },
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
    config = true,
  },
  {
    "kawre/leetcode.nvim",
    lazy = false,
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" }
  }
}
