vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup()

vim.keymap.set("n", "<leader>hn", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next hunk" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Previous hunk" })
vim.keymap.set("n", "gbb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
