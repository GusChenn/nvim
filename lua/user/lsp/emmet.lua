local helpers = require("user.helpers")
local lspconfig = helpers.SafeRequire("lspconfig")
local configs = helpers.SafeRequire("lspconfig/configs")
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

if not (lspconfig and configs) then
	return
end

lspconfig.emmet_ls.setup({
	-- on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})
