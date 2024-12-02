return {
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = true,
  },
  -- Colorschemes
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    priority = 1000,
  },
  {
    -- More high contrast
    "scottmckendry/cyberdream.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
  },
  {
    -- Github theme
    "projekt0n/github-nvim-theme",
    enabled = false,
    lazy = false,
    priority = 1000,
  },
  {
    "Tsuzat/NeoSolarized.nvim",
    enabled = false,
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
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require "config.long-configs.nvim-tree",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        "<leader>e",
        cmd "NvimTreeToggle",
        desc = "Toggle explorer",
      }
    end,
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
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
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["q"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
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
        matchup = {
          enable = true,
          disable_virtual_text = true,
        },
        ensure_installed = require("general-opts").treesitter.ensure_installed,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
      }
    end,
    init = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      ---@diagnostic disable-next-line: inject-field
      parser_config.embedded_template = {
        install_info = {
          url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
          files = { "src/parser.c" },
          requires_generate_from_grammar = true,
        },
        used_by = { "erb" },
      }
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      ---@usage 'background'|'foreground'|'virtual'
      render = "virtual",
      virtual_symbol = "⬤ ",

      enable_named_colors = true,
      enable_tailwind = true,
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    opts = require "config.long-configs.hlchunk",
  },
  {
    "RRethy/vim-illuminate",
    event = { "UIEnter" },
    config = function()
      require("illuminate").configure {
        modes_denylist = {
          "i",
          "ic",
          "ix",
        },
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
          "copilot-chat",
          "NvimTree",
          "[Quickfix List]",
        },
        providers = {
          "regex",
          "treesitter",
          "lsp",
        },
        min_count_to_highlight = 2,
        large_file_cutoff = 1000,
        large_file_config = nil,
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    event = "VeryLazy",
    config = function()
      local telescopeConfig = require "telescope.config"

      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--pcre2")

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then
          return tail
        end
        return string.format("%s\t\t%s", tail, parent)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })

      require("telescope").setup {
        defaults = {
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          results_title = false,
          prompt_title = false,
          preview_title = false,
          prompt_prefix = "  ",
          selection_caret = "  ",
          layout_strategy = "flex",
          vimgrep_arguments = vimgrep_arguments,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.9,
            },
            vertical = {
              width = 0.9,
              height = 0.9,
            },
          },
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            path_display = filenameFirst,
          },
          git_status = {
            path_display = filenameFirst,
          },
          live_grep = {
            path_display = filenameFirst,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "respect_case", -- or "ignore_case" or "respect_case"
          },
          undo = {
            use_delta = true,
            use_custom_command = nil,
            side_by_side = true,
            vim_diff_opts = {
              ctxlen = 10,
            },
            entry_format = "  $ID, $STAT, $TIME",
            time_format = "",
            saved_only = false,
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-r>"] = require("telescope-undo.actions").restore,
              },
              n = {
                ["y"] = require("telescope-undo.actions").yank_additions,
                ["Y"] = require("telescope-undo.actions").yank_deletions,
                ["u"] = require("telescope-undo.actions").restore,
              },
            },
          },
        },
      }

      require("telescope").load_extension "fzf"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      {
        -- Replaced it while https://github.com/RRethy/nvim-treesitter-endwise/pull/42 is not merged
        -- "RRethy/nvim-treesitter-endwise",
        "metiulekm/nvim-treesitter-endwise",
        lazy = false,
        dependencies = {
          "nvim-treesitter",
        },
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd
      local wk = require "which-key"

      wk.add {
        { "ff", cmd "Telescope find_files", desc = "Pick files" },
        { "fg", cmd "Telescope live_grep", desc = "Pick live grep" },
        { "fh", cmd "Telescope oldfiles", desc = "Pick oldfiles" },
        { "<leader>u", cmd "Telescope undo", desc = "Undo history" },
        { "<leader>b", cmd "Telescope buffers", desc = "Open bufferlist" },
        {
          "ff",
          'y<ESC> <CMD> Telescope find_files<CR><C-r>"',
          mode = "v",
          desc = "Search for selected text in files",
        },
        {
          "fg",
          'y<ESC> <CMD> Telescope live_grep<CR><C-r>"',
          mode = "v",
          desc = "Search for selected text in live grep",
        },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "tsx", "html", "eruby" },
    config = true,
  },
  {
    "nvim-neotest/neotest",
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
          enabled = false,
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
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
      vim.g.matchup_matchparen_nomode = "i"
      vim.g.matchup_matchparen_offscreen = {}

      vim.api.nvim_set_hl(0, "MatchParen", { link = "Underlined" })
      vim.api.nvim_set_hl(0, "MatchWord", { link = "Underlined" })
    end,
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "farmergreg/vim-lastplace",
    event = "UIEnter",
  },
  {
    "folke/persistence.nvim",
    dependencies = {
      "echasnovski/mini.nvim", -- necessary so it doesnt try to load the session before mini modules are up
      "zeioth/garbage-day.nvim", -- necessary so it can load LSPs,
    },
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = true,
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          label = {
            style = "overlay",
          },
        },
        char = {
          enabled = false,
        },
      },
    },
    init = function()
      require("which-key").add {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
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
              prompt_cursor = " ",
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
                local _, mode_hl = MiniStatusline.section_mode { trunc_width = 75 }
                local git_branch = MiniStatusline.section_git { icon = " " }
                local diagnostics = MiniStatusline.section_diagnostics {
                  trunc_width = 75,
                  icon = "",
                  signs = {
                    ERROR = " ",
                    WARN = " ",
                    INFO = " ",
                    HINT = " ",
                  },
                }
                local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
                local location = "󱨄 %P"
                local search = MiniStatusline.section_searchcount { trunc_width = 75 }

                -- Format filename
                -- local filename = vim.fn.expand('%:t')
                -- local extension = filename:match("^.+%.(.+)$")
                -- local filename_icon = require 'nvim-web-devicons'.get_icon(filename, extension, { default = true })
                -- local formatted_filename = filename_icon .. " " .. filename

                -- Format git branch name
                local formatted_git = ""
                if #git_branch <= 25 then
                  formatted_git = git_branch
                else
                  formatted_git = string.sub(git_branch, 1, 25) .. " "
                end

                -- Format tab numbers
                local tab_indicator = function()
                  local current_tab = vim.fn.tabpagenr()
                  local total_tabs = vim.fn.tabpagenr "$"
                  return string.format("  %d/%d", current_tab, total_tabs)
                end

                return MiniStatusline.combine_groups {
                  { hl = "NormalNC", strings = { formatted_git } },
                  "%=",
                  { hl = "NormalNC", strings = { diagnostics } },
                  "%=",
                  { hl = "NormalNC", strings = { tab_indicator() } },
                  { hl = "NormalNC", strings = { lsp } },
                  { hl = mode_hl, strings = { search, location } },
                }
              end,
            },
            use_icons = true,

            -- Whether to set Vim's settings for statusline (make it always shown with
            -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
            -- this to `false` and 'laststatus' to 3.
            set_vim_settings = false,
          },
        },
      }

      loaders.load_mini_modules(module_configs)
    end,
    -- commented out because i am using telescope
    -- init = function()
    --   local cmd = require("utils.plugin-helpers").cmd
    --   local wk = require "which-key"
    --
    --   wk.add {
    --     { "ff", cmd "Pick files", desc = "Pick files" },
    --     { "fg", cmd "Pick grep_live", desc = "Pick live grep" },
    --     { "fh", cmd "Pick oldfiles", desc = "Pick oldfiles" },
    --   }
    --
    --   wk.add {
    --     { "ff", 'y<ESC> <CMD> Pick files<CR><C-r>"', mode = "v", desc = "Search for selected text in files" },
    --     { "fg", 'y<ESC> <CMD> Pick grep_live<CR><C-r>"', mode = "v", desc = "Search for selected text in live grep" },
    --   }
    -- end,
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
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    opts = {
      icons = {
        ui = {
          bar = {
            separator = " / ",
          },
        },
      },
      bar = {
        hover = false,
        sources = function()
          local sources = require "dropbar.sources"
          return {
            sources.path,
          }
        end,
      },
    },
  },
  {
    "cdmill/focus.nvim",
    event = "VeryLazy",
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
    "r-cha/encourage.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "mistweaverco/kulala.nvim",
    lazy = false,
    init = function()
      require("which-key").add {
        {
          "<leader>rr",
          function()
            require("kulala").run()
          end,
          desc = "Open yankbank",
        },
      }

      vim.filetype.add {
        extension = {
          ["http"] = "http",
        },
      }
    end,
    opts = {
      icons = {
        inlay = {
          loading = " ",
          done = " ",
          error = " ",
        },
        lualine = "󱜿 ",
      },
    },
  },
  {
    "ptdewey/yankbank-nvim",
    dependencies = "kkharji/sqlite.lua",
    event = "VeryLazy",
    opts = {
      persist_type = "sqlite",
      sep = "",
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>yb", cmd "YankBank", desc = "Open yankbank" },
      }
    end,
  },
  {
    "chrisgrieser/nvim-early-retirement",
    opts = {
      retirementAgeMins = 10,
    },
    event = "VeryLazy",
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    config = function()
      require("statuscol").setup {
        relculright = true,
        thousands = ".",
        ft_ignore = {
          "help",
          "neo-tree",
          "toggleterm",
        },
      }
    end,
  },
}
