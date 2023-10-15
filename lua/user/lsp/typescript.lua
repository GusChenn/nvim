local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then
    print("Somthing went wrong with lspconfig")
    return
end

lspconfig.tsserver.setup {}
