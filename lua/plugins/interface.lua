return {
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = true,
  },
  -- Colorschemes
  -- Install without configuration
  {
    "projekt0n/github-nvim-theme",
    enabled = true,
    name = "github-theme",
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    enabled = true,
    name = "catppuccin",
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    enabled = true,
    version = false,
    lazy = false,
    priority = 1000,
  },
  {
    "neanias/everforest-nvim",
    enabled = false,
    version = false,
    lazy = false,
    priority = 1000,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.forestbones_darken_comments = 45
      vim.g.forestbones_lightness = "dim"
      vim.g.forestbones_solid_float_border = true
    end,
  },
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    lazy = false,
    priority = 1000,
  },
  {
    "dgox16/oldworld.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    enabled = true,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },
  {
    "zenbones-theme/zenbones.nvim",
    enabled = true,
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "hachy/eva01.vim",
    lazy = false,
    priority = 1000,
  },
  {
    "jesseleite/nvim-noirbuddy",
    enabled = false,
    dependencies = { { "tjdevries/colorbuddy.nvim" } },
    lazy = false,
    priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = {
        "icon",
        -- "permissions",
        "size",
        -- "mtime",
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["<C-v>"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Open the entry in a vertical split",
        },
        ["q"] = "actions.close",
      },
      use_default_keymaps = false,
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>e", cmd "Oil", desc = "Open Oil file explorer" },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        endwise = {
          enable = true,
        },
        ensure_installed = require("general-opts").treesitter.ensure_installed,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    -- Provides treesitter hl to erb files. Not declared as treesitter dependecy so it can be lazy loaded
    "tree-sitter/tree-sitter-embedded-template",
    ft = "eruby",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    filetype = { "erb", "html", "css", "scss", "javascript", "typescript", "typescriptreact", "javascriptreact" },
    opts = {
      ---@usage 'background'|'foreground'|'virtual'
      render = "background", -- virtual was causing performance issues
      enable_named_colors = true,
      enable_tailwind = true,
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    opts = {
      chunk = {
        enable = true,
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          left_top = "┌",
          vertical_line = "│",
          left_bottom = "└",
          right_arrow = "─",
        },
        style = {
          {
            -- TODO: Get color from theme
            fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID "MatchParen"), "bg", "gui"),
          },
        },
        max_file_size = 80 * 1024,
        delay = 0,
      },
      indent = {
        enable = false,
      },
      line_num = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = true,
  },
  {
    "nvim-neotest/neotest",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "tpope/vim-rails",
    },
    opts = function()
      return {
        adapters = {
          require "neotest-rspec",
        },
        diagnostic = {
          enabled = true,
        },
        status = {
          virtual_text = false,
          signs = true,
        },
        log_level = vim.log.levels.ERROR,
        icons = {
          expanded = " ",
          child_prefix = "",
          child_indent = "",
          final_child_prefix = "",
          non_collapsible = "",
          collapsed = "",

          passed = " ",
          running = " ",
          failed = " ",
          unknown = " ",
          skipped = " ",
        },
        floating = {
          border = "single",
          max_height = 0.8,
          max_width = 0.9,
        },
        summary = {
          mappings = {
            attach = "a",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            output = "o",
            run = "r",
            short = "O",
            stop = "u",
          },
        },
      }
    end,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd
      local neotest = require "neotest"

      require("which-key").add {
        { "<leader>nl", neotest.run.run, desc = "Run closest test" },
        {
          "<leader>nf",
          function()
            neotest.run.run(vim.fn.expand "%")
          end,
          desc = "Run all tests in file",
        },
        { "<leader>np", cmd "Neotest output-panel", desc = "Toggle output panel" },
        { "<leader>na", cmd "Neotest attach", desc = "Attach to currently running test" },
        { "<leader>ns", cmd "Neotest summary", desc = "Toggle summary panel" },
        {
          "<leader>t",
          function()
            if vim.bo.filetype ~= "ruby" then
              print "Not a ruby file"
              return
            end

            local current_file_path = vim.fn.expand "%:p:~:."
            local is_spec = string.match(current_file_path, "_spec")

            if is_spec then
              local app_file_path = current_file_path:gsub("([^/]+)", "app", 1):gsub("_spec%.", ".")

              vim.cmd("e " .. app_file_path)
            else
              local spec_file_path = current_file_path:gsub("([^/]+)", "spec", 1):gsub("%.", "_spec.")

              vim.cmd("e " .. spec_file_path)
            end
          end,
          desc = "Toggle test file",
        },
        { "<leader>T", cmd "R", desc = "Toggle related file with vim rails" },
      }
    end,
  },
  {
    "folke/ts-comments.nvim", -- Helps define the correct comment string according to language
    event = "VeryLazy",
    config = true,
  },
  {
    "farmergreg/vim-lastplace", -- Keeps position when reopening files
    event = "UIEnter",
  },
  {
    "folke/persistence.nvim",
    dependencies = {
      "echasnovski/mini.nvim", -- necessary so it doesnt try to load the session before mini modules are up
    },
    event = "BufReadPre",
    opts = {},
    init = function()
      require("which-key").add {
        {
          "<leader>sl",
          function()
            require("persistence").load()
          end,
          desc = "Load last directory session",
        },
      }
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      local loaders = require "utils.loaders"

      local hl_line = require("utils.plugin-helpers").highlight_line
      local hl_str = require("utils.plugin-helpers").highlight_string
      local pad_icons = require("utils.plugin-helpers").pad_icons
      local icons = require("utils.constants").icons
      local group_number = require("utils.plugin-helpers").group_number

      local module_configs = {
        { module = "ai" },
        { module = "bufremove" },
        { module = "pairs" },
        { module = "splitjoin" },
        { module = "surround" },
        {
          module = "pick",
          config = {
            window = {
              config = {
                border = "solid",
              },
              prompt_caret = " ",
              prompt_prefix = "  ",
            },
          },
        },
        { module = "extra" },
        {
          module = "sessions",
          config = {
            autoread = true,
          },
        },
        {
          module = "statusline",
          config = {
            content = {
              active = function()
                local git_branch = MiniStatusline.section_git { icon = " " }

                -- Format git branch name
                local formatted_git_branch = function()
                  local icon = git_branch:sub(1, 4)
                  local git_branch_without_details = git_branch:match ".*/(.+)$" or git_branch:sub(6)

                  if git_branch_without_details == "" then
                    return hl_line "NormalNC"
                  end

                  return icon .. " " .. git_branch_without_details
                end

                -- Format diagnostics
                local diagnostics = function()
                  return MiniStatusline.section_diagnostics {
                    trunc_width = 75,
                    icon = "",
                    signs = {
                      ERROR = hl_line "Red" .. "• ",
                      WARN = hl_line "Yellow" .. "• ",
                      INFO = hl_line "Green" .. "• ",
                      HINT = hl_line "Blue" .. "• ",
                    },
                  } .. hl_line "NormalNC"
                end

                -- Format LSP status
                local lsp = function()
                  local lsp_icons = ""
                  local buf_id = vim.api.nvim_get_current_buf()

                  local clients = vim.lsp.get_clients { buf_id }
                  for _, client in ipairs(clients) do
                    local client_icon = icons[client.name] or " "

                    lsp_icons = lsp_icons .. client_icon
                  end

                  return pad_icons(lsp_icons, 1)
                end

                -- Format tab numbers
                local tab_indicator = function()
                  local text = ""
                  local current_tab = vim.fn.tabpagenr()
                  local total_tabs = vim.fn.tabpagenr "$"

                  -- loop through all tabs and concatenate one "•" in the text variable for each tab
                  for i = 1, total_tabs do
                    if i == current_tab then
                      text = text .. hl_str("● ", "Added")
                    else
                      text = text .. hl_str("◦ ", "NormalNC")
                    end
                  end

                  return text .. hl_line "NormalNC"
                end

                -- From https://github.com/mcauley-penney/nvim
                local file_info = function()
                  local function get_filesize()
                    local suffix = { "b", "k", "M", "G", "T", "P", "E" }
                    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))

                    -- Handle invalid file size
                    if fsize <= 0 then
                      return "0b"
                    end

                    local i = math.floor(math.log(fsize) / math.log(1024))
                    -- Ensure index is within suffix range
                    i = math.min(i, #suffix - 1)

                    return string.format("%.1f%s", fsize / 1024 ^ i, suffix[i + 1])
                  end

                  local function get_vlinecount_str()
                    local raw_count = vim.fn.line "." - vim.fn.line "v"
                    raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

                    return group_number(math.abs(raw_count), ",")
                  end

                  local lines = group_number(vim.api.nvim_buf_line_count(0), ",")

                  local wc_table = vim.fn.wordcount()
                  if not wc_table.visual_words or not wc_table.visual_chars then
                    -- Normal mode word count and file info
                    return table.concat {
                      hl_str(icons.fileinfo, "Added"),
                      hl_line "NormalNC",
                      " ",
                      get_filesize(),
                      "  ",
                      lines,
                      " lines  ",
                      group_number(wc_table.words, ","),
                      " words ",
                    }
                  else
                    -- Visual selection mode: line count, word count, and char count
                    return table.concat {
                      hl_str(icons.visual_block, "Added"),
                      hl_line "NormalNC",
                      " ",
                      get_vlinecount_str(),
                      " lines  ",
                      group_number(wc_table.visual_words, ","),
                      " words  ",
                      group_number(wc_table.visual_chars, ","),
                      " chars",
                    }
                  end
                end

                local function scrollbar()
                  -- Get current scroll percentage
                  local percent = math.floor(vim.fn.line "." * 100 / vim.fn.line "$")
                  local icon = ""

                  -- Choose icon based on percentage
                  if percent < 33 then
                    icon = " " -- Scroll up icon
                  elseif percent < 66 then
                    icon = " " -- Scroll both ways icon
                  else
                    icon = "󱁫 " -- Scroll down icon
                  end

                  return "%p%% " .. icon
                end

                -- Format CodeCompanion loader
                -- For this to work, the autocmd from line 101 in the autocmds file is necessary
                -- local function code_companion_spinner()
                --   if _G.codecompanion_processing then
                --     return "󰟶 LLM thinking 󰟶 "
                --   else
                --     return " LLM done!  "
                --   end
                -- end

                return MiniStatusline.combine_groups {
                  { hl = "NormalNC", strings = { formatted_git_branch() } },
                  { hl = "NormalNC", strings = { diagnostics() } },
                  "%=",
                  -- { hl = "NormalNC", strings = { code_companion_spinner() } },
                  { hl = "NormalNC", strings = { file_info() } },
                  { hl = "NormalNC", strings = { tab_indicator() } },
                  { hl = "NormalNC", strings = { lsp() } },
                  { hl = "NormalNC", strings = { scrollbar() } },
                }
              end,
            },
            use_icons = true,

            set_vim_settings = false,
          },
        },
      }

      loaders.load_mini_modules(module_configs)
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "VeryLazy",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          "<Tab>",
          function()
            if vim.g.quickfix_context_expanded then
              require("quicker").collapse()
              vim.g.quickfix_context_expanded = false
            else
              require("quicker").expand { before = 2, after = 2, add_to_existing = true }
              vim.g.quickfix_context_expanded = true
            end
          end,
          desc = "Toggle quickfix context",
        },
      },
    },
  },
  {
    "cdmill/focus.nvim",
    mappings = "<leader>f",
    config = true,
    init = function()
      require("which-key").add {
        {
          "<leader>f",
          function()
            require("focus").toggle {
              window = {
                width = 0.9,
              },
            }
          end,
          desc = "Focus on current window",
        },
      }
    end,
  },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false, -- Recommended
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "chrisgrieser/nvim-early-retirement",
    opts = {
      retirementAgeMins = 10,
    },
    event = "VeryLazy",
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      image = {
        resolve = function(path, src)
          local api = require "obsidian.api"
          if api.path_is_note(path) then
            return api.resolve_attachment_path(src)
          end
        end,
      },
      bigfile = {},
      picker = {
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
            truncate = 70, -- truncate the file path to (roughly) this length
            filename_only = false, -- only show the filename
            icon_width = 2, -- width of the icon (in characters)
            git_status_hl = true, -- use the git status highlight group for the filename
          },
          selected = {
            show_always = false, -- only show the selected column when there are multiple selections
            unselected = true, -- use the unselected icon for unselected items
          },
          severity = {
            icons = true, -- show severity icons
            level = false, -- show severity level
            ---@type "left"|"right"
            pos = "left", -- position of the diagnostics
          },
        },
        layout = {
          layout = {
            width = 0,
            height = 0,
            border = "solid",
            title = "Good luck!",
          },
        },
        exclude = { "node_modules", ".git", ".venv" },
      },
    },
    init = function()
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end
      _G.bt = function()
        Snacks.debug.backtrace()
      end
      vim.print = _G.dd
    end,
    keys = {
      {
        "<leader>dd",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Snacks Diagnostics Picker",
      },
      {
        "ff",
        function()
          Snacks.picker.files {
            cmd = "rg",
            hidden = true,
            ignored = true,
            supports_live = true,
          }
        end,
        desc = "Snacks Diagnostics Picker",
      },
      {
        "fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Snacks Live Grep Picker",
      },
      {
        "fg",
        mode = "v",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Snacks Live Grep Picker",
      },
      {
        "<leader>aa",
        function()
          Snacks.picker.pick {
            source = "ai_assistant_picker",
            items = {
              { text = "Sidekick", value = "sidekick" },
              { text = "Codecompanion", value = "codecompanion" },
            },
            format = "text",
            layout = { preset = "select" },
            confirm = function(picker, item)
              picker:close()
              if not item then
                return
              end

              if item.value == "sidekick" then
                -- Run the Lua function for Sidekick
                local ok, sidekick = pcall(require, "sidekick.cli")
                if ok then
                  sidekick.toggle()
                else
                  vim.notify("Sidekick not found", vim.log.levels.ERROR)
                end
              elseif item.value == "codecompanion" then
                -- Run the Vim command for CodeCompanion
                vim.cmd "CodeCompanionActions"
              end
            end,
          }
        end,
        desc = "Select AI Assistant",
      },
      {
        "<leader>sp",
        function()
          local repos_path = vim.fn.expand "$REPOS_PATH"
          if repos_path == "" or repos_path == "$REPOS_PATH" then
            vim.notify("Error: $REPOS_PATH is not set", vim.log.levels.ERROR)
            return
          end

          Snacks.picker.pick {
            title = "Select Repository",
            finder = function()
              local paths = vim.fn.globpath(repos_path, "*/", 0, 1)
              local items = {}
              for _, path in ipairs(paths) do
                path = path:sub(1, -2)
                table.insert(items, {
                  text = vim.fn.fnamemodify(path, ":t"),
                  value = path,
                })
              end
              return items
            end,
            format = "text",
            confirm = function(picker, item)
              picker:close()
              if item then
                local path = item.value
                vim.cmd "tabnew"
                vim.api.nvim_set_current_dir(path)
              end
            end,
          }
        end,
        desc = "Open Repo from $REPOS_PATH",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
