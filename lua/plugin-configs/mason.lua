local lsp_zero = require("lsp-zero")

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
	},
})
