local opts = { noremap = true, silent = true }

-- [[ Shorten function name ]]
local keymap = vim.api.nvim_set_keymap

-- [[ Remap space as leader key ]]
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)
keymap("n", "<Space>", "<leader>", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- [[ Save shortcut ]]
keymap("n", "<C-s>", ":wa<CR>", opts)
keymap("n", "<C-c>", ":q<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-A-f>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)

-- Lspsaga
keymap("n", "gl", ":Lspsaga show_line_diagnostics<cr>", opts)
keymap("n", "K", ":Lspsaga hover_doc<cr>", opts)
keymap("n", "ca", ":Lspsaga code_action<cr>", opts)
keymap("n", "gr", ":Lspsaga lsp_finder<cr>", opts)
keymap("n", "gp", ":Lspsaga preview_definition<cr>", opts)

-- Nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Emmet
vim.g.user_emmet_leader_key = "<leader>t"

