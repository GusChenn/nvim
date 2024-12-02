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

    -- Telescope --
    TelescopePromptNormal = { link = "Visual" },
    TelescopePromptBorder = { link = "Visual" },
    TelescopePromptTitle = { link = "Visual" },
    TelescopePreviewNormal = { link = "StatusLine" },
    TelescopePreviewBorder = { link = "StatusLine" },
    TelescopePreviewTitle = { link = "StatusLine" },
    TelescopeResultsNormal = { link = "StatusLine" },
    TelescopeResultsBorder = { link = "StatusLine" },
    TelescopeResultsTitle = { link = "StatusLine" },
  }
end

return M
