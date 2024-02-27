local cmd = vim.api.nvim_create_autocmd

-- highlight yanked text
cmd({ "TextYankPost" }, {
	group = vim.api.nvim_create_augroup("HIGHLIGHT_YANKED_TEXT", {}),
	callback = function()
		local highlight = require("vim.highlight")
		highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})
