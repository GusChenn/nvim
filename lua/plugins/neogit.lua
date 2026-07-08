vim.pack.add({ "https://github.com/neogitorg/neogit" })

vim.keymap.set("n", "gs", "<cmd>Neogit<CR>", { desc = "Git status" })

require("neogit").setup({
  auto_show_console = true,
  disable_hint = true,
  disable_insert_on_commit = true,
  filewatcher = {
    interval = 1000,
    enabled = true,
  },
  signs = {
    hunk = { "", "" },
    item = { "➡", "⬇" },
    section = { "➡", "⬇" },
  },
  integrations = {
    fzf_lua = false,
    mini_pick = true
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
