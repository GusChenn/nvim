local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "vimdocs",
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
  },
}

M.lsp = {
  ensure_installed = {
    "cssls",
    "lua_ls",
    "html",
    "clangd",
    "solargraph",
    "marksman",
    "astro",
    "pylyzer",
  },
}

return M
