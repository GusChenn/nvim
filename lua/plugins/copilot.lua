vim.pack.add({
  "https://github.com/github/copilot.vim"
})

vim.keymap.set("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  silent = true,
})

vim.g.copilot_no_tab_map = true
