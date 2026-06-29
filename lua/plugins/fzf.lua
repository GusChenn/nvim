vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-mini/mini.icons"
})

require("fzf-lua").setup()

vim.keymap.set("n", "ff", function() FzfLua.files() end, { desc = "Find files" })
vim.keymap.set("n", "fg", function() FzfLua.live_grep() end, { desc = "Live grep" })
vim.keymap.set("v", "fg", function() FzfLua.grep_visual() end, { desc = "Visual live grep" })
