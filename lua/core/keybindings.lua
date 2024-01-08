local map = require("core.utils.utils").map

vim.g.mapleader = " " -- the leader key is the spacebar

local M = {}

-- Savind and closing buffers
map("n", "<C-w>", ":noautocmd w<cr>")
map("n", "<C-s>", ":w<cr>")
map("n", "<leader>q", ":bd!<cr>")
map("n", "<leader>Q", ":qa!<cr>")

-- Search and replace on file
map("n", "<leader>sr", "*<CMD>noh<CR>:%s//")

-- Image Pasting
map("n", "<leader>p", "<CMD>PasteImage<CR>", { desc = "Paste clipboard image" })

-- Trouble
map("n", "<leader>tr", "<CMD>TroubleToggle lsp_references<CR>")
map("n", "<leader>td", "<CMD>TroubleToggle lsp_definitions<CR>")
map("n", "<leader>cd", "<CMD>TroubleToggle<CR>")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree reveal toggle<CR>")

-- Searching and Highlighting
map("n", "m", "<CMD>noh<CR>")

-- Movement
-- in insert mode, type <c-d> and your cursor will move past the next separator
-- such as quotes, parens, brackets, etc.
map("i", "<C-d>", "<left><c-o>/[\"';)>}\\]]<cr><c-o><CMD>noh<cr><right>")
map("i", "<C-b>", "<C-o>0")
map("i", "<C-a>", "<C-o>A")
map("", "<A-k>", ":wincmd k<cr>")
map("", "<A-h>", ":wincmd h<cr>")
map("", "<A-j>", ":wincmd j<cr>")
map("", "<A-l>", ":wincmd l<cr>")
map("t", "<A-k>", "<cmd>wincmd k<cr>")
map("t", "<A-h>", "<cmd>wincmd h<cr>")
map("t", "<A-j>", "<cmd>wincmd j<cr>")
map("t", "<A-l>", "<cmd>wincmd l<cr>")
map("n", "t", "%")
map("n", "<leader>s", "*")

-- Splits
map("n", "<leader>wv", ":vsplit<cr>")
map("n", "<leader>wh", ":split<cr>")

-- Command mode
map("c", "<A-p>", "<Up>")
map("c", "<A-n>", "<Down>")

-- Telescope
map("n", "ff", "<CMD>lua require('user.utils.telescope-pickers').prettyFilesPicker({ picker = 'find_files' })<CR>")
map("n", "fg", "<CMD>lua require('user.utils.telescope-pickers').prettyGrepPicker({ picker = 'live_grep' })<cr>")
map("n", "fh", "<CMD>lua require('user.utils.telescope-pickers').prettyFilesPicker({ picker = 'oldfiles' })<cr>")
map("v", "fg", "y<ESC>:Telescope live_grep default_text=<C-r>0<CR>")
map("v", "ff", "y<ESC>:Telescope find_files default_text=<C-r>0<CR>")
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>")

-- Move lines and blocks
map("x", "<A-j>", ":m '>+1<CR>gv=gv")
map("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- More LSP stuff
_G.buf = vim.lsp.buf
-- lsp agnostic global rename
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }

		map("n", "rg", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "global substitution" })
		map("n", "gD", "<CMD>lua buf.declaration()<CR>", opts)
		map("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
		map("n", "K", "<CMD>lua buf.hover()<CR>", opts)
		map("n", "gi", "<CMD>lua buf.implementation()<CR>", opts)
		map("n", "gr", "<CMD>Telescope lsp_references<CR>", opts)
		map("n", "sh", "<CMD>lua buf.signature_help()<CR>", opts)
		map("n", "<leader>rn", "<CMD>lua buf.rename()<CR>", opts)
		map("n", "gl", "<CMD>lua buf.code_action()<CR>", opts)
	end,
})

-- NvTerm
map("t", "<A-t>", "<cmd>:lua require('nvterm.terminal').toggle('vertical')<cr>")
map("t", "<A-t><A-h>", "<cmd>:lua require('nvterm.terminal').toggle('horizontal')<cr>")
map("n", "<A-t>", "<cmd>:lua require('nvterm.terminal').toggle('vertical')<cr>")
map("n", "<A-t><A-h>", "<cmd>:lua require('nvterm.terminal').toggle('horizontal')<cr>")

-- Hop
map("n", "<leader>j", "<CMD>HopWord<CR>")

-- GitBlame
map("n", "<leader>gb", "<CMD>GitBlameToggle<CR>", { desc = "toggle git blame" })

-- Harpoon
map("n", "<leader>pp", function()
	---@diagnostic disable-next-line: different-requires
	require("harpoon"):list():append()
end)

-- to open quick menu
map("n", "<leader>p", function()
	---@diagnostic disable-next-line: different-requires
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)

map("n", "<leader>l", function()
	---@diagnostic disable-next-line: different-requires
	require("harpoon"):list():next()
end)

map("n", "<leader>h", function()
	---@diagnostic disable-next-line: different-requires
	require("harpoon"):list():prev()
end)

-- Diffview
map("n", "<leader>do", "<cmd>:DiffviewOpen<cr>")
map("n", "<leader>dc", "<cmd>:DiffviewClose<cr>")
map("n", "<leader>dr", "<cmd>:DiffviewRefresh<cr>")

-- Trouble
map("n", "<leader>dd", require("trouble").toggle)

-- Resize mode
map("n", "<leader>r", require("resize-mode").start)

-- Gitsigns
-- making this a function here because all it does is create keybinds for gitsigns but
-- it needs to be attached to an on_attach function.
M.gitsigns = function()
	local gs = package.loaded.gitsigns
	-- travel between hunks, backwards and forwards
	map("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "go to previous git hunk" })
	map("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "go to next git hunk" })

	map("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
	map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
	map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
	map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
	map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
	map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
	map("n", "<leader>hb", function()
		gs.blame_line({ full = true })
	end, { desc = "complete blame line history" })
	map("n", "<leader>lb", gs.toggle_current_line_blame, { desc = "toggle blame line" })
	-- diff at current working directory
	map("n", "<leader>hd", gs.diffthis, { desc = "diff at cwd" })
	-- diff at root of git repository
	map("n", "<leader>hD", function()
		gs.diffthis("~")
	end, { desc = "diff at root of git repo" })
	map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle deleted line" })
end

-- cmp (these are defined in cmp's configuration file)
-- ["<C-j>"] = cmp.mapping.scroll_docs(-4),
-- ["<C-k"] = cmp.mapping.scroll_docs(4),
-- ["<C-c>"] = cmp.mapping.abort(),
-- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
-- ["<C-b>"] = cmp_action.luasnip_jump_backward(),

-- Custom command mappings
map("n", "<leader>rs", ":RunScript<cr>")
map("n", "cpp", ":Cppath<cr>")
map("n", "spp", ":Path<cr>")

return M
