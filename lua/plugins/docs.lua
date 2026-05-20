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
    end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "personal",
          path = "$REPOS_PATH/second-brain/obsidian-vault",
        },
        {
          name = "claude_memory",
          path = "$REPOS_PATH/claude-second-brain",
        },
      },
      callbacks = {
        enter_note = function()
          -- remove the default mappings
          vim.keymap.del("n", "<CR>", { buffer = true })

          -- add your own
          vim.keymap.set("n", "<leader><CR>", require("obsidian.api").smart_action, { buffer = true })
        end,
      },
    },
    keys = function()
      local cmd = require("utils.plugin-helpers").cmd

      return {
        { "<leader>of", cmd "Obsidian follow_link", desc = "Open Obsidian Vault" },
        { "<leader>ob", cmd "Obsidian backlinks", desc = "Show Obsidian backlinks" },
        { "<leader>op", cmd "Obsidian paste_img", desc = "Paste image from clipboard" },
      }
    end,
  },
}
