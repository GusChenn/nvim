return {
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require "config.long-configs.nvim-tree",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add({
        "<leader>e", cmd "NvimTreeToggle", desc = "Toggle explorer"
      })
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
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

      parser_config.embedded_template = {
        install_info = {
          url                            = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
          files                          = { 'src/parser.c' },
          requires_generate_from_grammar = true,
        },
        used_by = { 'erb' }
      }
    end
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
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    event = "VeryLazy",
    config = function()
      require("telescope").setup(require "config.long-configs.telescope")
    end,
    init = function()
      local telescope = require "telescope"

      telescope.load_extension "fzf"
      telescope.load_extension "undo"
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    {
      "RRethy/nvim-treesitter-endwise",
      lazy = false,
      dependencies = {
        "nvim-treesitter",
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre " .. vim.fn.expand "~/" .. "Repos/studies/second-brain/Software Engineer Studies/**/**.md",
      "BufNewFile " .. vim.fn.expand "~/" .. "Repos/studies/second-brain/Software Engineer Studies/**/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter",
      "epwalsh/pomo.nvim",
    },
    config = function()
      require "config.long-configs.obsidian"
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
    },
    opts = function()
      return {
        adapters = {
          require "neotest-rspec",
        },
        diagnostic = {
          enabled = false,
        },
        log_level = vim.log.levels.TRACE,
        icons = {
          expanded = "",
          child_prefix = "",
          child_indent = "",
          final_child_prefix = "",
          non_collapsible = "",
          collapsed = "",

          passed = "",
          running = "",
          failed = "",
          unknown = "",
          skipped = "",
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

      require("which-key").add({
        { "<leader>nl", neotest.run.run,                                   desc = "Run closest test" },
        { "<leader>nf", function() neotest.run.run(vim.fn.expand "%") end, desc = "Run all tests in file", },
        { "<leader>np", cmd "Neotest output-panel",                        desc = "Toggle output panel", },
        { "<leader>ns", cmd "Neotest summary",                             desc = "Toggle summary panel", },
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
      })
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
      "echasnovski/mini.nvim",  -- necessary so it doesnt try to load the session before mini modules are up
      "zeioth/garbage-day.nvim" -- necessary so it can load LSPs,
    },
    event = "BufReadPre",       -- this will only start session saving when an actual file was opened
    config = true,
    init = function()
      require("which-key").add({
        { "<leader>sl", function() require("persistence").load() end, desc = "Load last directory session" }
      })
    end
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
      require("which-key").add({
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      })
    end
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
            -- content = {
            --   active = function()
            --     return " %t"
            --   end,
            -- },
            -- set_vim_settings = false,
          },
        },
      }

      loaders.load_mini_modules(module_configs)
    end,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd
      local wk = require "which-key"

      wk.add({
        { "ff", cmd "Pick files",     desc = "Pick files", },
        { "fg", cmd "Pick grep_live", desc = "Pick live grep", },
        { "fh", cmd "Pick oldfiles",  desc = "Pick oldfiles", },
      })

      wk.add({
        { "ff", 'y<ESC> <CMD> Pick files<CR><C-r>"',     mode = "v", desc = "Search for selected text in files", },
        { "fg", 'y<ESC> <CMD> Pick grep_live<CR><C-r>"', mode = "v", desc = "Search for selected text in live grep", },
      })
    end,
  },
  {
    'stevearc/quicker.nvim',
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
              require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
              vim.g.quickfix_context_expanded = true
            end
          end,
          desc = "Toggle quickfix context",
        },
      }
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    opts = {},
  },
  {
    'declancm/maximize.nvim',
    event = "VeryLazy",
    config = true
  }
}
