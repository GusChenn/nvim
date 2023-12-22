vim.cmd("autocmd!")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.o.termguicolors = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.signcolumn = "yes:1"
vim.wo.wrap = true
vim.opt.timeoutlen = 200
vim.opt.undofile = true

-- Define gutter icons
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- Customize how diagnostics are displayed
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
	float = {
		show_header = true,
		source = "if_many",
		border = "single",
		focusable = false,
	},
})

-- User defined commands
vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("Path", function()
	local path = vim.fn.expand("%:.")
	vim.notify('Path: "' .. path)
end, {})

vim.api.nvim_create_user_command("CleanBuffers", ":%bd|e#", {})

-- Config neovide
if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono:h13"
	-- vim.opt.linespace = 0
	vim.g.neovide_padding_top = 12
	vim.g.neovide_padding_bottom = 6
	vim.g.neovide_padding_right = 6
	vim.g.neovide_padding_left = 6
	vim.g.neovide_cursor_animate_in_insert_mode = true
	-- to disable smooth scrolling:
	-- vim.g.neovide_scroll_animation_length = 0
	vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end
