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
  }
end

return M
