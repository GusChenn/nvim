local helpers = require("user.helpers")
local null_ls = helpers.SafeRequire("null-ls")

if not null_ls then
	return
end

local formatting = null_ls.builtins.formatting
-- local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	sources = {
		formatting.prettierd,
		formatting.eslint_d,
		diagnostics.eslint_d,
		diagnostics.rubocop,
		formatting.stylua,
		diagnostics.selene,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
