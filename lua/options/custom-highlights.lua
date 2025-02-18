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
    -- Define = { italic = true },
    -- Keyword = { italic = true },
    -- ["@variable.builtin"] = { italic = true },
  }
end

return M
