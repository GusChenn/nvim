require("oldworld").setup {
  terminal_colors = true, -- enable terminal colors
  styles = { -- You can pass the style using the format: style = true
    comments = { italic = true },
    keywords = {}, -- style for keywords
    identifiers = {}, -- style for identifiers
    functions = {}, -- style for functions
    variables = {}, -- style for variables
    booleans = { italic = true }, -- style for booleans
  },
  integrations = { -- You can disable/enable integrations
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
  highlight_overrides = {
    Visual = { link = "QuickFixLine" },
    NormalNC = { link = "Normal" },
    NeogitDiffAdd = { link = "DiffAdd" },
    NeogitDiffDelete = { link = "DiffDelete" },
    NeogitDiffAddHighlight = { link = "DiffAdd" },
    NeogitDiffDeleteHighlight = { link = "DiffDelete" },
    TelescopePromptNormal = { link = "Pmenu" },
    TelescopePromptBorder = { link = "Pmenu" },
    TelescopePromptTitle = { link = "Pmenu" },
    TelescopePreviewNormal = { link = "Pmenu" },
    TelescopePreviewBorder = { link = "Pmenu" },
    TelescopePreviewTitle = { link = "Pmenu" },
    TelescopeResultsNormal = { link = "Pmenu" },
    TelescopeResultsBorder = { link = "Pmenu" },
    TelescopeResultsTitle = { link = "Pmenu" },
  },
}
