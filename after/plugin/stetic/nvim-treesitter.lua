local helpers = require("user.helpers")
local ts = helpers.SafeRequire("nvim-treesitter.configs")

if not ts then
	return
end

-- Workaround for some folds bug while using treesitter with packer.
-- WARNING: PERFORMANCE ISSUES
-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod     = 'expr'
--     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
--   end
-- })

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"tsx",
		"toml",
		"json",
		"yaml",
		"css",
		"html",
		"lua",
		"ruby",
		"javascript",
		"typescript",
		"graphql",
		"markdown",
		"markdown_inline",
	},
	endwise = {
		enable = true,
	},
})
