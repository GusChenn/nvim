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
    "neanias/everforest-nvim",
    enabled = false,
    version = false,
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/gruvbox-material",
    enabled = false,
    lazy = false,
    priority = 1000,
  },
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
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
        ["<C-h>"] = {
          "actions.select",
          opts = { horizontal = true },
          desc = "Open the entry in a horizontal split",
        },
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
  },
  {
    -- Provides treesitter hl to erb files. Not declared as treesitter dependecy so it can be lazy loaded
    "tree-sitter/tree-sitter-embedded-template",
    ft = "erb",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      ---@usage 'background'|'foreground'|'virtual'
      render = "background", -- virtual was causing performance issues
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
        status = {
          virtual_text = true,
          signs = false,
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

                -- From https://github.com/mcauley-penney/nvim
                local function scrollbar()
                  local sbar_chars = {
                    "▔",
                    "🮂",
                    "🬂",
                    "🮃",
                    "▀",
                    "▄",
                    "▃",
                    "🬭",
                    "▂",
                    "▁",
                  }

                  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
                  local lines = vim.api.nvim_buf_line_count(0)

                  local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
                  local sbar = string.rep(sbar_chars[i], 2)

                  return hl_str(sbar, "Added") .. hl_line "NormalNC"
                end

                return MiniStatusline.combine_groups {
                  { hl = "NormalNC", strings = { formatted_git_branch() } },
                  { hl = "NormalNC", strings = { diagnostics() } },
                  "%=",
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
    enabled = false,
    lazy = false,
    config = function()
      -- local builtin = require("statuscol.builtin")
      require("statuscol").setup {
        -- configuration goes here, for example:
        setopt = true,
        relculright = true,
        ft_ignore = { "oil" },
        segments = {
          {
            text = { " " },
          },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa",
          },
          -- {
          --   sign = {
          --     namespace = { "GitSigns" },
          --     maxwidth = 1,
          --     colwidth = 1,
          --     fillchar = "│",
          --     fillcharhl = "@comment",
          --   },
          -- },
          -- {
          --   sign = {
          --     namespace = { "<diagnostic/gitsigns>" },
          --     maxwidth = 1,
          --     colwidth = 1,
          --   },
          --   condition = {
          --     function()
          --       return true
          --     end,
          --   },
          -- },
          -- { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          -- {
          --   sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
          --   click = "v:lua.ScSa"
          -- },
          -- { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
          -- {
          --   sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          --   click = "v:lua.ScSa"
          -- },
        },
      }
    end,
  },
  {
    dir = "~/Repos/postit-nvim",
    opts = {},
    dev = true,
    cmd = "Postit",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>pa", ":Postit add ", desc = "Start adding a postit" },
        { "<leader>tp", cmd "Postit toggle", desc = "Toggle postit visibility" },
        { "<leader>pn", cmd "Postit next", desc = "Next postit" },
        { "<leader>pe", cmd "Postit edit", desc = "Edit postits in buffer" },
      }
    end,
  },
  {
    "Tyler-Barham/floating-help.nvim",
    cmd = "FloatingHelp",
    keys = { "<leader>th" },
    opts = {
      width = 0.6, -- Whole numbers are columns/rows
      height = 0.9, -- Decimals are a percentage of the editor
      position = "W", -- NW,N,NW,W,C,E,SW,S,SE (C==center)
      border = "rounded", -- rounded,double,single
    },
    init = function()
      local fh = require "floating-help"

      require("which-key").add {
        { "<leader>th", fh.toggle, desc = "Toggle floating help" },
      }

      -- Only replace cmds, not search; only replace the first instance
      local function cmd_abbrev(abbrev, expansion)
        local cmd = "cabbr "
          .. abbrev
          .. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
          .. expansion
          .. '" : "'
          .. abbrev
          .. '")<CR>'
        vim.cmd(cmd)
      end

      -- Redirect `:h` to `:FloatingHelp`
      cmd_abbrev("h", "FloatingHelp")
      cmd_abbrev("help", "FloatingHelp")
      cmd_abbrev("helpc", "FloatingHelpClose")
      cmd_abbrev("helpclose", "FloatingHelpClose")
    end,
  },
}
