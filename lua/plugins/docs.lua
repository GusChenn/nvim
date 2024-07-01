return {
  -- Too new for now
  -- {
  --   "OXY2DEV/markview.nvim",
  --   ft = "markdown",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   name = "markview",
  --   -- config = true,
  --   opts = {
  --     header = {
  --       {
  --         -- sign = " ",
  --         -- icon = "",
  --       },
  --     },
  --   },
  -- },
  {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = {
      markdown = {
        bullets = { "󰬺", "󰬻", "󰬼", "󰬽" },
        fat_headlines = true,
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre " .. vim.fn.expand "~/" .. "Repos/studies/**/**.md",
      "BufNewFile " .. vim.fn.expand "~/" .. "Repos/studies/**/**.md",
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
}
