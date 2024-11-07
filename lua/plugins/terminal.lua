return {
  {
    "christoomey/vim-tmux-navigator",
    enabled = false, -- not necessary anymore since im using kitty
    lazy = false,
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.g.tmux_navigator_no_wrap = 1
    end,
  },
  {
    "knubie/vim-kitty-navigator",
    lazy = false,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      vim.g.kitty_navigator_no_mappings = 1
      vim.g.kitty_navigator_enable_stack_layout = 0

      require("which-key").add {
        { "<A-k>", cmd "KittyNavigateUp", desc = "Focus pane up" },
        { "<A-j>", cmd "KittyNavigateDown", desc = "Focus pane down" },
        { "<A-h>", cmd "KittyNavigateLeft", desc = "Focus pane left" },
        { "<A-l>", cmd "KittyNavigateRight", desc = "Focus pane right" },
      }
    end,
  },
}
