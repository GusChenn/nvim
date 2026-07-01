vim.pack.add({ 'https://github.com/Wansmer/treesj' })

require('treesj').setup()

vim.keymap.set("n", "gS", require('treesj').toggle, { desc = "Toggle split/join" })
