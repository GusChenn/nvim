vim.pack.add({ "https://github.com/neogitorg/neogit" })

vim.keymap.set("n", "gs", "<cmd>Neogit<CR>", { desc = "Git status" })

require("neogit").setup({
  disable_hint = true,
  disable_insert_on_commit = true,
  signs = {
    hunk = { "", "" },
    item = { "➡", "⬇" },
    section = { "➡", "⬇" },
  },
  mappings = {
    popup = {
      ["l"] = false,
    },
    status = {
      ["l"] = "Toggle",
    },
  },
})
