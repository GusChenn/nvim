vim.pack.add({
  {
    src = 'https://github.com/nvim-mini/mini.pick',
    version = 'stable',
  },
})

require("mini.pick").setup()

-- vim.keymap.set("n", "ff", MiniPick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "fg", MiniPick.builtin.grep_live, { desc = "Live grep" })
vim.keymap.set("n", "fb", MiniPick.builtin.buffers, { desc = "List open buffers" })

local smart_pick = require('core.custom_pickers.smart_pick')

smart_pick.setup()
vim.keymap.set('n', 'ff', smart_pick.picker)
