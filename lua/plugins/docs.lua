return {
  {
    "OXY2DEV/markview.nvim",
    event = "VeryLazy",
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
          horizontal_rules = {},
          list_items = {
            shift_width = 2,
          },
          headings = {
            shift_width = 1,
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
        code_blocks = {
          style = "simple",
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

      wk.add {
        { "<C-Space>", cmd "Checkbox toggle", desc = "Toggle checkbox state" },
      }
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre " .. vim.fn.expand "~/" .. "Repos/second-brain/**/*",
      "BufNewFile " .. vim.fn.expand "~/" .. "Repos/second-brain/**/*",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter",
      "epwalsh/pomo.nvim",
    },
    config = function()
      require("obsidian").setup {
        workspaces = {
          {
            name = "Personal",
            path = "~/Repos/second-brain/obsidian-vault",
          },
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        mappings = {
          ["<leader>oft"] = {
            action = function()
              return "<CMD> ObsidianTag <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>on"] = {
            action = function()
              -- Prompt the user for a task name
              local task_name = vim.fn.input "Enter task name: "
              if task_name == "" then
                print "Task name cannot be empty"
                return
              end

              -- Create the new file
              vim.cmd("ObsidianNew " .. task_name)

              -- Applies the subtask template
              vim.cmd "ObsidianTemplate Subtask template"
            end,
          },
          ["<leader>off"] = {
            action = function()
              return "<CMD> ObsidianQuickSwitch <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>ofl"] = {
            action = function()
              return "<CMD> ObsidianFollowLink <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>obl"] = {
            action = function()
              return "<CMD> ObsidianBacklinks <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>ot"] = {
            action = function()
              return "<CMD> ObsidianToday <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>oT"] = {
            action = function()
              return "<CMD> ObsidianTomorrow <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
        },
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
          local dir_notes = vim.fn.readdir(vim.fn.expand "%:p:h")

          local new_note_number = #dir_notes + 1
          local new_note_name = new_note_number .. " " .. tostring(spec.title)

          local path = spec.dir / new_note_name
          return path:with_suffix ".md"
        end,

        daily_notes = {
          folder = "obsidian-vault/Notes/dailies",
          date_format = "%Y-%m-%d",
          alias_format = "%B %-d, %Y",
          default_tags = { "daily-notes" },
          template = "daily",
        },

        templates = {
          folder = "obsidian-vault/Templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
          -- A map for custom variables, the key should be the variable and the value a function
          substitutions = {
            daily_note_title = function()
              return os.date "%a, %B %d"
            end,
          },
        },

        ---@param url string
        follow_url_func = function(url)
          -- Open the URL in the default web browser.
          vim.fn.jobstart { "open", url } -- Mac OS
        end,

        ui = {
          checkboxes = {},
          bullets = {},
          reference_text = { hl_group = "ObsidianRefText" },
          highlight_text = { hl_group = "ObsidianHighlightText" },
          tags = { hl_group = "ObsidianTag" },
          block_ids = { hl_group = "ObsidianBlockID" },
          hl_groups = {
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
          },
        },
      }
    end,
  },
}
