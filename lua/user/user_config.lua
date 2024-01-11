local M = {}

-- add any null-ls sources you want here
M.setup_sources = function(b)
	return {
		b.code_actions.gitsigns,
		-- js
		b.formatting.prettierd,
		b.diagnostics.eslint_d,
		b.code_actions.eslint_d,
		-- ruby
		b.diagnostics.rubocop,
		-- lua
		b.formatting.stylua,
		b.diagnostics.selene,
	}
end

-- add sources to auto-install
M.ensure_installed = {
	null_ls = {
		"stylua",
	},
	dap = {},
	mason = {
		"tsserver",
		"lua_ls",
		"solargraph",
	},
	treesitter = {
		"lua",
		"vim",
		"vimdoc",
		"json",
		"python",
		"toml",
		"javascript",
		"angular",
		"bash",
		"css",
		"dockerfile",
		"html",
		"org",
		"ruby",
	},
}

-- add servers to be used for auto formatting here
M.formatting_servers = {
	["rust_analyzer"] = { "rust" },
	["lua_ls"] = { "lua" },
	["null_ls"] = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"ruby",
	},
}

-- options you put here will override or add on to the default options
M.options = {
	opt = {
		confirm = true,
	},
}

-- add extra configuration options here, like extra autocmds etc.
-- feel free to create your own separate files and require them in here
M.user_conf = function()
	vim.cmd([[
  autocmd VimEnter * lua vim.notify("Welcome to CyberNvim!", "info", {title = "Neovim"})]])
	-- require("user.autocmds")
	-- vim.cmd("colorscheme elflord")
end

return M
