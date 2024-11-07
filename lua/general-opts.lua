local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "ruby",
    "bash",
    "gitcommit",
    "gitignore",
    "json",
    "python",
    "scss",
  },
}

M.lsp = {
  ensure_installed = {
    "cssls",
    "lua_ls",
    "ruby_lsp",
    "pylyzer",
  },
}

M.conform = {
  blacklist = {
    "**/node_modules/**",
    "**/plugins/**",
  },
}

return M
