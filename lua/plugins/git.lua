return {
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "sindrets/diffview.nvim",
      -- "nvim-telescope/telescope.nvim",
      "folke/snacks.nvim",
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
        telescope = false,
        snacks = true,
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
            { "<leader>hr", gs.reset_hunk, desc = "Reset hunk" },
            { "<leader>hP", gs.preview_hunk, desc = "Preview hunk" },
            { "<leader>gd", gs.diffthis, desc = "Diffthis" },
            { "<leader>hs", gs.stage_hunk, desc = "Stage hunk" },
            { "<leader>hu", gs.undo_stage_hunk, desc = "Unstage hunk" },
            { "gbb", gs.blame, desc = "Open git blame sidepanel" },
            {
              "<leader>hn",
              function()
                gs.nav_hunk "next"
              end,
              desc = "Next hunk",
            },
            {
              "<leader>hp",
              function()
                gs.nav_hunk "prev"
              end,
              desc = "Previous hunk",
            },
          }
        end,
      }
    end,
  },
}
