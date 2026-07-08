vim.pack.add({
  "https://github.com/cdmill/focus.nvim"
})

require("focus").setup()

vim.keymap.set("n", "<leader>f", function()
  require("focus").toggle({
    window = {
      width = 0.9,
    },
  })
end, { desc = "Toggle focus mode" })
