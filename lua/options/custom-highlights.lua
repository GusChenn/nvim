local M = {}

M.custom_highlights = function()
  return {
    -- General --
    FloatTitle = { link = "NormalFloat" },
    FloatBorder = { link = "NormalFloat" },
    CodeBlock = { link = "DiffChange" },

    -- Mini module --
    MiniPickMatchCurrent = { link = "PmenuExtraSel" },

    -- Flash --
    FlashLabel = { bg = "NvimLightGreen", bold = true, italic = true },

    -- TreeSitter --
    ["@type.ruby"] = { link = "Yellow" },

    -- StatusLine --
    StatusLine = { link = "NormalNC" },

    -- Telescope --
    TelescopePromptNormal = { link = "Pmenu" },
    TelescopePromptBorder = { link = "Pmenu" },
    TelescopePromptTitle = { link = "Pmenu" },
    TelescopePreviewNormal = { link = "StatusLine" },
    TelescopePreviewBorder = { link = "StatusLine" },
    TelescopePreviewTitle = { link = "StatusLine" },
    TelescopeResultsNormal = { link = "StatusLine" },
    TelescopeResultsBorder = { link = "StatusLine" },
    TelescopeResultsTitle = { link = "StatusLine" },

    -- Change selected text color
    Visual = { fg = "#e78a4e", bg = "#3c3836" },
  }
end

return M
