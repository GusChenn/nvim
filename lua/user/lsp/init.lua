local status, lspconfig = pcall(require, "lspconfig")
if not status then
	print("Somthing went wrong with lspconfig base")
	return
end

require("user.lsp.lua")
require("user.lsp.typescript-tools")
require("user.lsp.solargraph")
