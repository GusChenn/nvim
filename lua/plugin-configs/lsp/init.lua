local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

local exist, user_config = pcall(require, "user.user_config")

local sources = exist
		and type(user_config) == "table"
		and user_config.ensure_installed
		and user_config.ensure_installed.mason
	or {}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = sources,
	handlers = {
		lsp_zero.default_setup,
		tsserver = function()
			require("typescript-tools").setup({})
		end,
	},
})

-- Customize diagnostics looks
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
