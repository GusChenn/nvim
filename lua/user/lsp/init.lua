local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then
    print("Somthing went wrong with lspconfig base")
    return
end

require("user.lsp.lua")
