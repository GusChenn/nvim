local M = {}

M.custom_highlights = function()
  return {
    -- General --
    FloatBorder = { link = "NormalFloat" },

    -- Mini module --
    MiniPickMatchCurrent = { link = "PmenuExtraSel" },

    -- Flash --
    FlashLabel = { bg = "NvimLightGreen", bold = true, italic = true },
  }
end

return M
