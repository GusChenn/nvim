local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd
local ucmd = vim.api.nvim_create_user_command

-- enables suport for inlay hints with virtual text
cmd("LspAttach", {
	group = augroup("LspAttach_inlayhints", { clear = true }),
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})

-- Fixes some bugs with how treesitter manages folds
cmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	desc = "fix tree sitter folds issue",
	group = augroup("treesitter folds", { clear = true }),
	pattern = { "*" },
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
})

-- Removes any trailing whitespace when saving a file
cmd({ "BufWritePre" }, {
	desc = "remove trailing whitespace on save",
	group = augroup("remove trailing whitespace", { clear = true }),
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- remembers file state, such as cursor position and any folds
augroup("remember file state", { clear = true })
cmd({ "BufWinLeave" }, {
	desc = "remember file state",
	group = "remember file state",
	pattern = { "*.*" },
	command = "mkview",
})
cmd({ "BufWinEnter" }, {
	desc = "remember file state",
	group = "remember file state",
	pattern = { "*.*" },
	command = "silent! loadview",
})

-- enables coloring hexcodes and color names in css, jsx, etc.
cmd({ "Filetype" }, {
	desc = "activate colorizer",
	pattern = "css,scss,html,xml,svg,js,jsx,ts,tsx,php,vue",
	group = augroup("colorizer", { clear = true }),
	callback = function()
		require("colorizer").attach_to_buffer(0, {
			mode = "background",
			css = true,
		})
	end,
})

-- disables autocomplete in some filetypes
cmd({ "FileType" }, {
	desc = "disable cmp in certain filetypes",
	pattern = "gitcommit,gitrebase,text,markdown",
	group = augroup("cmp_disable", { clear = true }),
	command = "lua require('cmp').setup.buffer { enabled = false}",
})

-- fixes Trouble not closing when last window in tab
cmd("BufEnter", {
	group = vim.api.nvim_create_augroup("TroubleClose", { clear = true }),
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "Trouble"
			and layout[3] == nil
		then
			vim.cmd("confirm quit")
		end
	end,
})

-- highlight yanked text
cmd({ "TextYankPost" }, {
	group = vim.api.nvim_create_augroup("HIGHLIGHT_YANKED_TEXT", {}),
	callback = function()
		local highlight = require("vim.highlight")
		highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

-- save session on buff write
cmd({ "BufWritePre" }, {
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			-- Don't save while there's any 'nofile' buffer open.
			if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
				return
			end
		end
		require("session_manager").save_current_session()
	end,
})

-- User defined commands
ucmd("Cppath", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

ucmd("Path", function()
	local path = vim.fn.expand("%:.")
	vim.notify('Path: "' .. path)
end, {})

ucmd("CleanBuffers", ":%bd|e#", {})
