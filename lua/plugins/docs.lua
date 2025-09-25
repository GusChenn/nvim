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

      wk.add {
        { "<C-Space>", cmd "Checkbox toggle", desc = "Toggle checkbox state" },
      }
    end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    event = "VeryLazy",
    cond = function()
      return vim.fn.getcwd() == vim.fn.expand "~/Repos/second-brain"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      "OXY2DEV/markview.nvim",
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
          blink = false,
          min_chars = 2,
        },
        callbacks = {
          enter_note = function(_, note)
            -- This is the new recommended way to set up buffer-local mappings.
            --
            -- See `:help obsidian.nvim-callbacks`

            -- Passthrough "gf" to follow markdown links.
            vim.keymap.set("n", "gf", function()
              return require("obsidian").util.gf_passthrough()
            end, {
              buffer = note.bufnr,
              noremap = false,
              expr = true,
              desc = "Follow link under cursor",
            })

            vim.keymap.set("n", "<leader>oft", "<CMD>Obsidian tags<CR>", {
              buffer = note.bufnr,
              desc = "Obsidian Tags",
            })

            vim.keymap.set("n", "<leader>on", function()
              -- Prompt the user for a task name
              local task_name = vim.fn.input "Enter task name: "
              if task_name == "" then
                print "Task name cannot be empty"
                return
              end

              -- Create the new file
              vim.cmd("Obsidian new " .. task_name)

              -- Applies the subtask template
              vim.cmd "Obsidian template Subtask template"
            end, {
              buffer = note.bufnr,
              desc = "Obsidian New Task",
            })

            vim.keymap.set("n", "<leader>ofl", "<CMD>Obsidian follow_link<CR>", {
              buffer = note.bufnr,
              desc = "Obsidian Follow Link",
            })

            vim.keymap.set("n", "<leader>obl", "<CMD>Obsidian backlinks<CR>", {
              buffer = note.bufnr,
              desc = "Obsidian Backlinks",
            })
          end,
        },
        picker = {
          name = "telescope.nvim",
          -- Not all pickers support all mappings.
          note_mappings = {
            -- Create a new note from your query.
            new = "<C-x>",
            -- Insert a link to the selected note.
            insert_link = "<C-l>",
          },
          tag_mappings = {
            -- Add tag(s) to current note.
            tag_note = "<C-x>",
            -- Insert a tag at the current location.
            insert_tag = "<C-l>",
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
        org_default_notes_file = "~/Repos/second-brain/obsidian-vault/org-files/refile.org",
        org_todo_keywords = { "TODO", "DOING", "|", "DONE" },
        org_todo_keyword_faces = {
          TODO = ":foreground #8d9df2 :weight bold :slant italic",
          DOING = ":foreground #2b7ab5 :weight bold :slant italic",
          DONE = ":foreground #388024 :weight bold :slant italic",
        },
        org_startup_indented = false,
        org_adapt_indentation = true,
        win_split_mode = "vertical",
      }

      local wk = require "which-key"

      wk.add {
        {
          "<leader>ot",
          "<CMD> e ~/Repos/second-brain/obsidian-vault/org-files/refile.org <CR>",
          desc = "Open refile.org",
        },
      }

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
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
  },
}
