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
    local map = vim.keymap.set

    -- Load default mappings
    -- api.config.mappings.default_on_attach(bufnr)
    map("n", "h", api.node.navigate.parent_close, opts "Up")
    map("n", "l", api.node.open.edit, opts "Up")
  end,
}
