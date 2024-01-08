local exist, user_config = pcall(require, "user.user_config")
local sources = exist
		and type(user_config) == "table"
		and user_config.ensure_installed
		and user_config.ensure_installed.treesitter
	or {}

require("nvim-treesitter.configs").setup({
	ensure_installed = sources,
	highlight = {
		enable = true,
		disable = { "html", "org" },
	},
	incremental_selection = { enable = true },
	autotag = { enable = true },
	rainbow = { enable = true, disable = { "html" }, extended_mode = false },
	additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
	endwise = { enable = true },
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
