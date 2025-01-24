-- Default options
require("github-theme").setup {
  options = {
    transparent = false,
    dim_inactive = false, -- Non focused panes set to alternative background
    styles = { -- Style to be applied to different syntax groups
      comments = "italic", -- Value is any valid attr-list value `:help attr-list`
      functions = "NONE",
      keywords = "NONE",
      variables = "NONE",
      conditionals = "NONE",
      constants = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "italic",
    },
    modules = {
      alpha = false,
      cmp = true,
      flash = true,
      gitsigns = true,
      hop = false,
      indent_blankline = false,
      lazy = true,
      lsp = true,
      markdown = true,
      mason = true,
      navic = false,
      neo_tree = false,
      neorg = false,
      noice = false,
      notify = false,
      rainbow_delimiters = false,
      telescope = true,
      treesitter = true,
    },
  },
  palettes = {},
  specs = {},
  groups = {},
}
