vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp",            version = vim.version.range('1.*') },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink.cmp").setup({
  keymap = { preset = 'super-tab' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
