-- Neovide specific configs

vim.o.guifont = "JetBrainsMono NF:h13"
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_refresh_rate = 120

vim.keymap.set("n", "<C-S-V>", '"+P') -- Paste normal mode
vim.keymap.set("v", "<C-S-V>", '"+P') -- Paste visual mode
vim.keymap.set("c", "<C-S-V>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<C-S-V>", '<ESC>l"+Pli') -- Paste insert mode

-- -- Allow clipboard copy paste in neovim
-- vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })
