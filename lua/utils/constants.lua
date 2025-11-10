local python_icon = " "

local constants = {
  icons = {
    python = python_icon,
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
    efm = " ",
    eslint = "󰱺 ",
    ruff = " ",
    css_ls = " ",
    html = " ",
    pyright = python_icon,
  },
  hl_map = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
  },
}

return constants
