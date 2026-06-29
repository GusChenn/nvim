local map = require("core.helpers.map")

vim.pack.add({
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/stevearc/oil.nvim',
})

require("mini.icons").setup()

require("oil").setup({
  keymaps = {
    ["<C-p>"] = "actions.preview",
    ["q"] = { "actions.close", mode = "n" },
    ["<C-r>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["`"] = false,
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["g~"] = false,
    ["gs"] = false,
    ["gx"] = false,
    ["g."] = false,
    ["g\\"] = false,
  },
  columns = {
    "icon",
    -- "permissions",
    "size",
    "mtime",
  },
  view_options = {
    show_hidden = true,
  }
})

map("n", "<leader>e", "Oil", { desc = "Open file explorer" })
