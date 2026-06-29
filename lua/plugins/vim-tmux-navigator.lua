local map = require("core.helpers.map")

vim.pack.add({
	'https://github.com/christoomey/vim-tmux-navigator',
})

vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_no_wrap = 1

map("n", "<C-k>", "TmuxNavigateUp", { desc = "Focus pane up" })
map("n", "<C-j>", "TmuxNavigateDown", { desc = "Focus pane down" })
map("n", "<C-h>", "TmuxNavigateLeft", { desc = "Focus pane left" })
map("n", "<C-l>", "TmuxNavigateRight", { desc = "Focus pane right" })
