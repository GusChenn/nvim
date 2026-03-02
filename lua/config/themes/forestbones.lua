local lush = require "lush"
local base = require "forestbones"
local hsl = lush.hsl

local specs = lush.parse(function()
  return {
    Function { base.Function, fg = base.Function.fg.darken(40) },
    IncSearch { bg = hsl "#A3CFF5", fg = hsl "#000000" },
    Search { bg = hsl "#A3CFF5", fg = hsl "#000000" },
    StatusLineNC = { base.StatusLine },
    Visual { base.Visual, fg = hsl "#946115", gui = "bold" },
    NormalFloat { base.Normal, bg = base.Normal.bg.darken(2) },
    FloatBorder { base.NormalFloat },
    Pmenu { base.Normal },
  }
end)

lush.apply(lush.compile(specs))
