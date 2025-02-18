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
        checkboxes = {
          checked = {
            text = " ",
            hl = "MarkviewCheckboxChecked",
            scope_hl = "Comment",
          },
          unchecked = {
            text = " ",
            hl = "MarkviewCheckboxUnchecked",
            scope_hl = nil,
          },

          custom = {},
        },
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
            enable = false,
          },
          headings = {
            shift_width = 2,
            heading_1 = {
              sign = "",
              sign_hl = "MarkviewHeading2Sign",
            },
            heading_2 = {
              sign = "",
              sign_hl = "MarkviewHeading2Sign",
            },
            heading_3 = {
              sign = "",
              sign_hl = "MarkviewHeading2Sign",
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

      wk.add {
        {
          "<CR>",
          function()
            if string.gsub(vim.fn.getline ".", " ", "") == "" then
              vim.api.nvim_put({ "- [ ] " }, "", false, true)
            else
              vim.cmd "Checkbox toggle"
            end
          end,
          desc = "Toggle checkbox state",
        },
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
        -- A list of workspace names, paths, and configuration overrides.
        -- If you use the Obsidian app, the 'path' of a workspace should generally be
        -- your vault root (where the `.obsidian` folder is located).
        -- When obsidian.nvim is loaded by your plugin manager, it will automatically set
        -- the workspace to the first workspace in the list whose `path` is a parent of the
        -- current markdown file being edited.
        workspaces = {
          {
            name = "Personal",
            path = "~/Repos/second-brain/obsidian-vault",
          },
        },

        log_level = vim.log.levels.INFO,

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
          ["<leader>ot"] = {
            action = function()
              return "<CMD> ObsidianTemplate <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
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
          ["<leader>gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>oT"] = {
            action = function()
              return "<CMD> ObsidianToday <CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>ft"] = {
            action = function()
              return require("utils.plugin-helpers").pick_folder_files "database/tasks"
            end,
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

        templates = {
          folder = "obsidian-vault/Templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
          -- A map for custom variables, the key should be the variable and the value a function
          substitutions = {
            daily_note_title = function()
              return os.date "Standup topics: %a, %B %d"
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
