return {
  chunk = {
    enable = true,
    use_treesitter = true,
    chars = {
      horizontal_line = "─",
      left_top = "┌",
      vertical_line = "│",
      left_bottom = "└",
      right_arrow = "─",
    },
    style = {
      {
        -- TODO: Get color from theme
        fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID "MatchParen"), "bg", "gui"),
      },
    },
    max_file_size = 80 * 1024,
    delay = 0,
  },
  indent = {
    enable = false,
  },
  line_num = {
    enable = false,
  },
  blank = {
    enable = false,
  },
}
