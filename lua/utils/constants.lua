local constants = {
  icons = {
    lua_ls = " ",
    ruby_lsp = " ",
    rubocop = "󱚝 ",
    cssls = " ",
    ["GitHub Copilot"] = " ",
    searchcount = " ",
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
