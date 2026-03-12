local lush = require "lush"
local base = require "forestbones"
local hsl = lush.hsl

local specs = lush.parse(function(injected_functions)
  local sym = injected_functions.sym

  return {
    Function { base.Function, fg = base.Function.fg.darken(40) },
    IncSearch { bg = hsl "#A3CFF5", fg = hsl "#000000" },
    Search { bg = hsl "#A3CFF5", fg = hsl "#000000" },
    StatusLineNC = { base.StatusLine },
    Visual { base.Visual, fg = hsl "#946115", gui = "bold" },
    NormalFloat { base.Normal, bg = base.Normal.bg.darken(2) },
    FloatBorder { base.NormalFloat },
    Pmenu { base.Normal },
    CustomOrgHeadlineBullet { bg = hsl "#453e39", fg = hsl "#f5d1a4", gui = "bold" },
    sym "@org.headline.level1.org" { bg = hsl "#453e39", fg = hsl "#f5d1a4", gui = "bold" },
    sym "@org.headline.level2.org" { bg = hsl "#453e39", fg = hsl "#f5d1a4", gui = "bold" },
    sym "@org.headline.level3.org" { bg = hsl "#453e39", fg = hsl "#f5d1a4", gui = "bold" },
    sym "@org.headline.level4.org" { bg = hsl "#453e39", fg = hsl "#f5d1a4", gui = "bold" },
    sym "@org.headline.level5.org" { bg = hsl "#453e39", fg = hsl "#f5d1a4", gui = "bold" },
  }
end)

lush.apply(lush.compile(specs))
