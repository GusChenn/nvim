local M = {}

-- Store colors in a local table
local colors = {
  -- Base colors
  charcoal = "#242629",
  cloud_white = "#ccd2d9",
  pure_black = "#000000",
  pure_white = "#FFFFFF",
  deep_purple = "#875FAF",
  neon_green = "#87FF5F",
  soft_red = "#db6088",
  dark_gray = "#2c2d2f",

  -- Grays and neutral tones
  slate_gray = "#656475",
  light_slate = "#8c8b98",
  dusky_purple = "#535177",
  dark_purple_gray = "#353240",
  purple_gray = "#3b3847",
  pale_gray = "#a1a0ad",

  -- Purple tones
  soft_purple = "#cfa1ed",
  bright_purple = "#ab92fc",
  deep_violet = "#b968fc",
  lavender = "#858fe6",

  -- Blues
  soft_blue = "#a4d2ec",
  steel_blue = "#85b0e6",
  powder_blue = "#9dafd1",
  dusty_blue = "#76839d",
  slate_blue = "#6d7ba6",

  -- Greens
  pale_green = "#9cda7c",

  -- Yellows and oranges
  bright_yellow = "#dedc52",
  wheat = "#e6bb85",
  pale_yellow = "#d9d057",
  peach = "#e39e74",
  burnt_orange = "#d99145",

  -- Pinks and magentas
  magenta = "#ce67f0",
  rose_pink = "#d67cc4",

  -- Teals
  bright_teal = "#6cdde6",

  -- Browns
  copper = "#6e4c28",
  rose_brown = "#b67e5d",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

local highlights = {
  -- UI Elements
  ColorColumn = { bg = colors.deep_purple },
  Conceal = { fg = colors.neon_green },
  CurSearch = { fg = colors.pure_black, bg = colors.wheat, bold = true },
  Cursor = { fg = colors.pure_black, bg = colors.neon_green },
  CursorIM = { bg = colors.soft_red },
  CursorColumn = { bg = colors.dark_gray },
  CursorLine = { bg = colors.dark_gray },
  Directory = { fg = colors.pale_green },
  DiffAdd = { fg = colors.pure_black, bg = colors.pale_green },
  DiffDelete = { fg = colors.soft_red },
  DiffText = { fg = colors.pure_black, bg = colors.soft_red, bold = true },

  -- More UI Elements
  EndOfBuffer = { fg = colors.neon_green },
  ErrorMsg = { fg = colors.soft_red, bg = "#2b1211", bold = true },
  VertSplit = { fg = colors.deep_purple },
  Folded = { fg = colors.deep_purple, bg = colors.dark_gray, bold = true },
  LineNr = { fg = colors.slate_gray },
  CursorLineNr = { fg = colors.light_slate, bold = true },

  -- Syntax Highlighting
  Comment = { fg = colors.pale_gray },
  Constant = { fg = colors.peach },
  String = { fg = colors.soft_purple },
  Character = { fg = colors.rose_pink },
  Number = { fg = colors.bright_yellow },
  PreProc = { fg = colors.magenta },
  Include = { fg = colors.deep_violet },
  Identifier = { fg = colors.soft_blue },
  Function = { fg = colors.pale_green },
  Statement = { fg = colors.bright_purple },
  Type = { fg = colors.steel_blue },

  -- Git Signs
  GitGutterAdd = { fg = colors.pale_green, bold = true },
  GitGutterChange = { fg = colors.burnt_orange, bold = true },
  GitGutterDelete = { fg = colors.soft_red, bold = true },

  -- LSP
  LspErrorText = { fg = colors.soft_red, bg = "#2b1211" },
  LspErrorHighlight = { undercurl = true, sp = colors.soft_red },
  LspWarningText = { fg = colors.pale_yellow, bg = "#2b2a11" },
  LspWarningHighlight = { undercurl = true, sp = colors.pale_yellow },
  LspInformationText = { fg = colors.bright_teal, bg = "#162c2e" },
  LspInformationHighlight = { undercurl = true, sp = colors.bright_teal },
}

-- Define links in a table
local links = {
  Boolean = "Constant",
  Float = "Number",
  Conditional = "Statement",
  Repeat = "Statement",
  Operator = "Statement",
  Keyword = "Statement",
  Label = "Identifier",
  Exception = "PreProc",
  Define = "Statement",
  Macro = "PreProc",
  PreCondit = "PreProc",
  StorageClass = "Identifier",
  Structure = "Type",
  Tag = "Statement",
  Delimiter = "Statement",
}

-- Function to set up all highlights
local function set_highlights()
  -- Clear existing highlights
  -- vim.cmd "highlight clear"
  -- if vim.fn.exists "syntax_on" then
  --   vim.cmd "syntax reset"
  -- end
  vim.o.termguicolors = true
  vim.g.colors_name = "eva01-custom"

  -- Apply all highlights
  for group, opts in pairs(highlights) do
    hi(group, opts)
  end

  -- Apply all links
  for from, to in pairs(links) do
    link(from, to)
  end
end

-- Public function to setup the colorscheme
function M.setup()
  set_highlights()
end

-- Public function to get the colors table
function M.get_colors()
  return colors
end

return M
