local opts = { noremap = true, silent = true }
local helpers = require("user.helpers")

local vim_keymap = vim.api.nvim_set_keymap
local lua_keymap = vim.keymap.set

-- Fundamentals
vim_keymap("", "<Space>", "<Nop>", opts)
vim_keymap("n", "<C-l>", ":noh<cr>", opts)
vim_keymap("n", "<C-s>", ":w<cr>", opts)
vim_keymap("n", "<C-x>", ":bd!<cr>", opts)
vim_keymap("v", "<leader>s", "*<ESC>", opts)
vim_keymap("v", "Y", '"+y', opts)

-- Nvim tree
vim_keymap("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", opts)

-- Navigation
vim_keymap("n", "<A-k>", ":wincmd k<cr>", opts)
vim_keymap("n", "<A-h>", ":wincmd h<cr>", opts)
vim_keymap("n", "<A-j>", ":wincmd j<cr>", opts)
vim_keymap("n", "<A-l>", ":wincmd l<cr>", opts)
vim_keymap("n", "<leader>wv", ":vsplit<cr>", opts)
vim_keymap("n", "<leader>wh", ":split<cr>", opts)
vim_keymap("n", "ff", ":Telescope find_files<cr>", opts)
vim_keymap("n", "fg", ":Telescope live_grep<cr>", opts)
vim_keymap("n", "fb", ":Telescope buffers<cr>", opts)
vim_keymap("n", "fh", ":Telescope help_tags<cr>", opts)
vim_keymap("n", "<leader>?", ":lua require'telescope.builtin'.keymaps{}<cr>", opts)

-- Telescope
vim_keymap("v", "fg", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", opts)

-- Lsp
-------------------------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- lua_keymap('n', '<space>e', vim.diagnostic.open_float)
lua_keymap("n", "g p", vim.diagnostic.goto_prev)
lua_keymap("n", "g n", vim.diagnostic.goto_next)
lua_keymap("n", "<leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local lsp_opts = { buffer = ev.buf }

		-- lua_keymap('n', 'gD', vim.lsp.buf.declaration, opts)
		-- lua_keymap('n', 'gd', vim.lsp.buf.definition, opts)
		-- lua_keymap('n', 'gi', vim.lsp.buf.implementation, opts)
		-- lua_keymap('n', '<space>D', vim.lsp.buf.type_definition, opts)
		-- lua_keymap('n', 'gr', vim.lsp.buf.references, opts)
		lua_keymap("n", "K", vim.lsp.buf.hover, lsp_opts)
		lua_keymap("n", "<C-k>", vim.lsp.buf.signature_help, lsp_opts)
		-- lua_keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, lsp_opts)
		-- lua_keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, lsp_opts)
		-- lua_keymap("n", "<space>rn", vim.lsp.buf.rename, lsp_opts)
		lua_keymap({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, lsp_opts)
		lua_keymap("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
})
---------------------------------------

-- BufferLine

-- for i = 1, 20 do
-- 	local key = "<leader>" .. i
-- 	local command = ':lua require("bufferline").go_to(' .. i .. ", true)<cr>"
-- 	lua_keymap("n", key, command, opts)
-- end

-- lua_keymap("n", "<leader>l", ":BufferLineCycleNext<cr>", opts)
-- lua_keymap("n", "<leader>h", ":BufferLineCyclePrev<cr>", opts)
-- lua_keymap("n", "<leader>fl", ":BufferLineMoveNext<cr>", opts)
-- lua_keymap("n", "<leader>fh", ":BufferLineMovePrev<cr>", opts)

-- Lspsaga
lua_keymap("n", "gr", ":Lspsaga finder ref<cr>", opts)
lua_keymap("n", "gt", ":Lspsaga peek_definition<cr>", opts)
lua_keymap("n", "gd", ":Lspsaga goto_definition<cr>", opts)
lua_keymap("n", "gh", ":Lspsaga hover_doc<cr>", opts)
lua_keymap("n", "gl", ":Lspsaga diagnostic_jump_next<cr>", opts)

-- Resize mode
lua_keymap("n", "<leader>r", ":lua require('resize-mode').start()<cr>", opts)

-- Cheatsheet
vim_keymap("n", "cc", ":Cheatsheet!<cr>", opts)

-- Diffview
vim_keymap("n", "<leader>g", "<cmd>:DiffviewFileHistory %<cr>", opts)

-- ZenMode
vim_keymap("n", "<leader>z", "<cmd>:ZenMode<cr>", opts)

-- Vim fugitite
lua_keymap("n", "<leader>gs", vim.cmd.Git)

-- Harpoon
lua_keymap("n", "<leader>p", helpers.SafeRequire("harpoon.mark").add_file)
lua_keymap("n", "<leader>pp", helpers.SafeRequire("harpoon.ui").toggle_quick_menu)

-- Diaglist
lua_keymap("n", "<leader>dd", helpers.SafeRequire("diaglist").open_all_diagnostics)
lua_keymap("n", "<leader>db", helpers.SafeRequire("diaglist").open_buffer_diagnostics)
