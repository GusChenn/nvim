local cmd = vim.api.nvim_create_autocmd
local ucmd = vim.api.nvim_create_user_command

-- highlight yanked text
cmd({ "TextYankPost" }, {
	group = vim.api.nvim_create_augroup("HIGHLIGHT_YANKED_TEXT", {}),
	callback = function()
		local highlight = require("vim.highlight")
		highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
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
