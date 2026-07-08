vim.pack.add({
  "https://github.com/shellraining/hlchunk.nvim"
})

require("hlchunk").setup({
  chunk = {
    enable = true,
    duration = 0,
    delay = 0,
    chars = {
      horizontal_line = "━",
      vertical_line = "┃",
      left_top = "┏",
      left_bottom = "┗",
      right_arrow = "━",
    }
  },
  indent = {
    enable = true,
  },
  line_num = {
    enable = false,
  },
  blank = {
    enable = false,
  },
})
