local M = {}

M.custom_highlights = function()
  return {
    -- General --
    -- FloatTitle = { link = "NormalFloat" },
    -- FloatBorder = { link = "NormalFloat" },
    -- CodeBlock = { link = "DiffChange" },

    -- Mini module --
    -- MiniPickMatchCurrent = { link = "PmenuExtraSel" },

    -- StatusLine --
    StatusLine = { link = "NormalNC" },

    -- Treesitter --
    -- ["@type.tsx"] = { link = "@type" },
  }
end

return M
