return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    config = true,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd
      require("which-key").add {
        { "<leader>dd", cmd "Trouble diagnostics toggle", desc = "Toggle diagnostics" },
      }
    end,
  },
  {
    "f-person/git-blame.nvim",
    cmd = { "GitBlameToggle" },
    name = "gitblame",
    opts = {
      enabled = false,
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "gbb", cmd "GitBlameToggle", desc = "Toggle git blame" },
      }
    end,
  },
  {
    "tpope/vim-fugitive",
    enabled = false,
    cmd = { "G" },
  },
  -- {
  --   "sindrets/diffview.nvim",
  --   cmd = { "DiffviewOpen", "DiffviewClose" },
  --   opts = {
  --     diff_binaries = false,
  --     enhanced_diff_hl = true,
  --     git_cmd = { "git" },
  --     hg_cmd = { "hg" },
  --     use_icons = false,
  --     show_help_hints = false,
  --     watch_index = true,
  --     icons = {
  --       folder_closed = "",
  --       folder_open = "",
  --     },
  --     signs = {
  --       fold_closed = "➡ ",
  --       fold_open = "⬇ ",
  --       done = "✓",
  --     },
  --     file_panel = {
  --       listing_style = "tree", -- One of 'list' or 'tree'
  --       win_config = {
  --         position = "left",
  --         width = 35,
  --         win_opts = {
  --           signcolumn = "no",
  --           foldcolumn = "0",
  --         },
  --       },
  --     },
  --     file_history_panel = {
  --       win_config = {
  --         position = "bottom",
  --         height = 16,
  --         win_opts = {
  --           signcolumn = "no",
  --           foldcolumn = "0",
  --         },
  --       },
  --     },
  --     commit_log_panel = {
  --       win_config = {
  --         win_opts = {
  --           signcolumn = "no",
  --           foldcolumn = "0",
  --         },
  --       },
  --     },
  --     hooks = {
  --       diff_buf_read = function()
  --         vim.opt_local.foldcolumn = "0"
  --       end,
  --       view_enter = function()
  --         vim.opt_local.foldcolumn = "0"
  --       end,
  --       diff_buf_win_enter = function()
  --         vim.opt_local.foldcolumn = "0"
  --       end,
  --     },
  --   },
  --   init = function()
  --     local cmd = require("utils.plugin-helpers").cmd
  --
  --     require("which-key").add {
  --       { "<leader>do", cmd "DiffviewOpen", desc = "Open diffview" },
  --       { "<leader>dc", cmd "DiffviewClose", desc = "Close diffview" },
  --     }
  --   end,
  -- },
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      auto_show_console = true,
      disable_hint = true,
      disable_insert_on_commit = true,
      filewatcher = {
        interval = 1000,
        enabled = true,
      },
      signs = {
        hunk = { "", "" },
        item = { "➡", "⬇" },
        section = { "➡", "⬇" },
      },
      integrations = {
        telescope = true,
        mini_pick = false,
        diffview = false,
      },
      mappings = {
        popup = {
          ["l"] = false,
        },
        status = {
          ["l"] = "Toggle",
        },
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "gs", cmd "Neogit", desc = "Open Neogit" },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      local gs = require "gitsigns"
      local wc = require "which-key"

      gs.setup {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "│" },
          topdelete = { text = "┆" },
          changedelete = { text = "┆" },
          untracked = { text = "┆" },
        },
        on_attach = function()
          wc.add {
            { "<leader>rh", gs.reset_hunk, desc = "Reset hunk" },
            { "<leader>ph", gs.preview_hunk, desc = "Preview hunk" },
            { "<leader>gd", gs.diffthis, desc = "Diff" },
          }
        end,
      }
    end,
  },
}
