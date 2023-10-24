local helpers = require("user.helpers")
local lspconfig = helpers.SafeRequire("lspconfig")

if not lspconfig then
	return
end

lspconfig.emmet_ls.setup({
	-- on_attach = on_attach,
	-- capabilities = capabilities,
	-- flags = lsp_flags,
})
