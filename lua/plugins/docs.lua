return {
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
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
}
