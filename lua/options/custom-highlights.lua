local M = {}

M.custom_highlights = function()
  return {
    -- General --
    FloatTitle = { link = "NormalFloat" },
    FloatBorder = { link = "NormalFloat" },
    -- CodeBlock = { link = "DiffChange" },

    -- Mini module --
    MiniPickMatchCurrent = { link = "PmenuExtraSel" },

    -- StatusLine --
    StatusLine = { link = "NormalNC" },

    -- Treesitter --
    Define = { italic = true },
    Keyword = { italic = true },
    ["@variable.builtin"] = { italic = true },

    -- Telescope -- chore: remove this and add colorscheme-specific overrides
    -- TelescopePromptNormal = { link = "Pmenu" },
    -- TelescopePromptBorder = { link = "Pmenu" },
    -- TelescopePromptTitle = { link = "Pmenu" },
    -- TelescopePreviewNormal = { link = "StatusLine" },
    -- TelescopePreviewBorder = { link = "StatusLine" },
    -- TelescopePreviewTitle = { link = "StatusLine" },
    -- TelescopeResultsNormal = { link = "StatusLine" },
    -- TelescopeResultsBorder = { link = "StatusLine" },
    -- TelescopeResultsTitle = { link = "StatusLine" },
  }
end

return M
