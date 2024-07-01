return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    config = true,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd
      require("which-key").register {
        ["<leader>dd"] = {
          cmd "Trouble diagnostics toggle",
          "Toggle diagnostics",
        },
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

      require("which-key").register {
        gbb = {
          cmd "GitBlameToggle",
          "Toggle git blame",
        },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    opts = {
      diff_binaries = false,
      enhanced_diff_hl = true,
      git_cmd = { "git" },
      hg_cmd = { "hg" },
      use_icons = false,
      show_help_hints = false,
      watch_index = true,
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "➡ ",
        fold_open = "⬇ ",
        done = "✓",
      },
      file_panel = {
        listing_style = "tree", -- One of 'list' or 'tree'
        win_config = {
          position = "left",
          width = 35,
          win_opts = {
            signcolumn = "no",
            foldcolumn = "0",
          },
        },
      },
      file_history_panel = {
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {
            signcolumn = "no",
            foldcolumn = "0",
          },
        },
      },
      commit_log_panel = {
        win_config = {
          win_opts = {
            signcolumn = "no",
            foldcolumn = "0",
          },
        },
      },
      hooks = {
        diff_buf_read = function()
          vim.opt_local.foldcolumn = "0"
        end,
        view_enter = function()
          vim.opt_local.foldcolumn = "0"
        end,
        diff_buf_win_enter = function()
          vim.opt_local.foldcolumn = "0"
        end,
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").register({
        ["do"] = {
          cmd "DiffviewOpen",
          "Open diffview",
        },
        dc = {
          cmd "DiffviewClose",
          "Close diffview",
        },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      auto_show_console = false,
      disable_hint = true,
      disable_insert_on_commit = true,
      filewatcher = {
        interval = 1000,
        enabled = false,
      },
      signs = {
        hunk = { "", "" },
        item = { "➡", "⬇" },
        section = { "➡", "⬇" },
      },
      integrations = {
        telescope = true,
        diffview = true,
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

      require("which-key").register {
        gs = {
          cmd "Neogit",
          "Open Neogit",
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "│" },
        topdelete = { text = "┆" },
        changedelete = { text = "┆" },
        untracked = { text = "┆" },
      },
    },
    init = function()
      local gs = require "gitsigns"

      require("which-key").register({
        rh = {
          gs.reset_hunk,
          "Reset hunk",
        },
        ph = {
          gs.preview_hunk,
          "Preview hunk",
        },
        gd = {
          gs.diffthis,
          "Diff",
        },
      }, { prefix = "<leader>" })
    end,
  },
}
