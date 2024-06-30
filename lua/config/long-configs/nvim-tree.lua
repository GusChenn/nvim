return {
  view = {
    width = 60,
    side = "right",
  },
  filters = {
    enable = false,
  },
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"
    local opts = require("utils.plugin-helpers").opts
    local map = vim.api.nvim_buf_set_keymap

    -- Load default mappings
    api.config.mappings.default_on_attach(bufnr)
    require("which-key").register {
      n = {
        buffer = bufnr,
        api.node.navigate.parent_close "Close",
      },
      l = {
        buffer = bufnr,
        api.node.open.edit,
        "Close",
      },
    }
  end,
}
