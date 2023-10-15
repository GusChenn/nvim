local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then
    print("Somthing went wrong with lspconfig lua")
    return
end

local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if (not status) then
    print("Somthing went wrong with cmp_nvim_lsp lua")
    return
end

lspconfig.lua_ls.setup {
    settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}
