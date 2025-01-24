local constants = {
  icons = {
    lua_ls = " ",
    ruby_lsp = " ",
    solargraph = " ",
    rubocop = "󱚝 ",
    clangd = "C",
    cssls = " ",
    ["GitHub Copilot"] = " ",
    ts_ls = " ",
    fileinfo = "󰈚 ",
    visual_block = "󰒉 ",
  },
  hl_map = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
  },
}

return constants
