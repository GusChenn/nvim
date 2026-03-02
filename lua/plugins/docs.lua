return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("markview").setup {
        max_length = 99999,
        preview = {
          filetypes = {
            "markdown",
            "codecompanion",
          },
          ignore_filetypes = {},
          ignore_buftypes = {},
        },
        markdown = {
          code_blocks = {
            style = "block",
          },
          list_items = {
            shift_width = 2,
          },
          headings = {
            shift_width = 2,
            heading_1 = {
              sign = "",
              -- sign_hl = "MarkviewHeading2Sign",
            },
            heading_2 = {
              sign = "",
              -- sign_hl = "MarkviewHeading2Sign",
            },
            heading_3 = {
              sign = "",
              -- sign_hl = "MarkviewHeading2Sign",
            },
          },
        },
        markdown_inline = {
          checkboxes = {
            unchecked = { text = "󰄰", hl = "MarkviewCheckboxPending", scope_hl = "Normal" },
            ["n"] = {
              text = "",
              hl = "MarkviewCheckboxUnchecked",
              scope_hl = "MarkviewCheckboxUnchecked",
            },
          },
        },
      }

      require("markview.extras.checkboxes").setup {
        remove_markers = true,
        exit = true,

        default_marker = "-",
        default_state = "x",

        states = {
          { " ", "x" },
        },
      }

      local wk = require "which-key"
      local cmd = require("utils.plugin-helpers").cmd

      -- wk.add {
      --   { "<C-Space>", cmd "Checkbox toggle", desc = "Toggle checkbox state" },
      -- }
    end,
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    -- cond = function()
    --   return vim.fn.getcwd() == vim.fn.expand('~/Repos/second-brain')
    -- end,
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = "~/Repos/second-brain/obsidian-vault/org-files/**/*",
        org_default_notes_file = "~/Repos/second-brain/obsidian-vault/org-files/todo.org",
        org_todo_keywords = { "TODO", "DOING", "|", "DONE" },
        org_todo_keyword_faces = {
          TODO = ":foreground #8d9df2 :weight bold :slant italic",
          DOING = ":foreground #2b7ab5 :weight bold :slant italic",
          DONE = ":foreground #388024 :weight bold :slant italic",
        },
        org_startup_indented = false,
        org_adapt_indentation = true,
        win_split_mode = "vertical",
        org_id_link_to_org_use_id = true,
      }

      local wk = require "which-key"

      wk.add {
        {
          "<leader>ot",
          "<CMD> e ~/Repos/second-brain/obsidian-vault/org-files/refile.org <CR>",
          desc = "Open refile.org",
        },
      }
    end,
  },
  {
    "chipsenkbeil/org-roam.nvim",
    event = "VeryLazy",
    tag = "0.2.0",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
        tag = "0.7.0",
      },
    },
    config = function()
      require("org-roam").setup {
        directory = "~/Documents/org-roam/",
        -- optional
        org_files = {
          "~/Repos/second-brain/obsidian-vault/org-files",
        },
      }
    end,
    init = function()
      local wc = require "which-key"
      local cmd = require("utils.plugin-helpers").cmd

      wc.add {
        { "<leader>nh", cmd "Org store_link", desc = "Create org id for nearest heading" },
      }
    end,
  },
  {
    "hamidi-dev/org-list.nvim",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-repeat", -- for repeatable actions with '.'
    },
    config = function()
      require("org-list").setup {
        mapping = {
          key = "<leader>lt",
          desc = "Toggle: Cycle through list types",
        },
        checkbox_toggle = {
          enabled = true,
          -- NOTE: for nvim-orgmode users, you should change the following mapping OR change the one from orgmode.
          -- If both mapping stay the same, the one from nvim-orgmode will "win"
          key = "<C-Space>",
          desc = "Toggle checkbox state",
          filetypes = { "org", "markdown" },
        },
      }
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    event = "VeryLazy",
    config = function()
      require("org-bullets").setup {
        symbols = {
          headlines = { "󰛘", "󰛘", "󰛘", "󰛘" },
          list = " ",
          checkboxes = {
            half = { " ", "@org.checkbox.halfchecked" },
            done = { " ", "@org.keyword.done" },
            todo = { " ", "@org.keyword.todo" },
          },
        },
      }
    end,
  },
}
