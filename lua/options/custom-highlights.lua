local M = {}

M.custom_catppuccin_highlights = function(colors)
  return {
    LineNr = { fg = colors.text },
    Folded = { fg = colors.blue },
    Visual = { sp = colors.text, underline = true },
    IndentBlankLineContextChar = { fg = colors.sapphire },
    WinSeparator = { fg = colors.text },
    -- TelescopeSelection = { bg = colors.subtext1 },
    -- TelescopeBorder            = { fg = colors.base, bg = colors.base },
    -- CursorLine = { bg = colors.text },
    NvimTreeWinSeparator = { fg = colors.text },
    NvimTreeGitNew = { fg = colors.green },
    NvimTreeGitDirty = { fg = colors.yellow },
    NvimTreeGitDeleted = { fg = colors.red },
    -- ColorColumn = { bg = colors. },
    SpecialKey = { fg = colors.yellow },
    SagaBorder = {
      fg = colors.blue,
    },
    HoverNormal = { fg = colors.text },

    -- Gitsigns
    GitSignsAddInline = { link = "DiffAdd" },
    GitSignsDeleteInline = { link = "DiffDelete" },
    GitSignsChangedInline = { link = "DiffChange" },

    StNormalMode = { fg = colors.surface0, bg = colors.blue, bold = true },
    StVisualMode = { fg = colors.surface0, bg = colors.sky, bold = true },
    StInsertMode = { fg = colors.surface0, bg = colors.lavender, bold = true },
    StTerminalMode = { fg = colors.surface0, bg = colors.green, bold = true },
    StNTerminalMode = { fg = colors.surface0, bg = colors.yellow, bold = true },
    StReplaceMode = { fg = colors.surface0, bg = colors.peach, bold = true },
    StConfirmMode = { fg = colors.surface0, bg = colors.sapphire, bold = true },
    StCommandMode = { fg = colors.surface0, bg = colors.green, bold = true },
    StSelectMode = { fg = colors.surface0, bg = colors.blue, bold = true },

    StInviSep = { bg = colors.surface1, fg = colors.surface1 },
    StNormalModeSep = { bg = colors.surface1, fg = colors.blue },
    StVisualModeSep = { bg = colors.surface1, fg = colors.sky },
    StInsertModeSep = { bg = colors.surface1, fg = colors.lavender },
    StTerminalModeSep = { bg = colors.surface1, fg = colors.green },
    StNTerminalModeSep = { bg = colors.surface1, fg = colors.yellow },
    StReplaceModeSep = { bg = colors.surface1, fg = colors.peach },
    StConfirmModeSep = { bg = colors.surface1, fg = colors.sapphire },
    StCommandModeSep = { bg = colors.surface1, fg = colors.green },
    StSelectModeSep = { bg = colors.surface1, fg = colors.blue },

    --CurFile
    StCwd = { bg = colors.yellow, fg = colors.base },
    StFile = { bg = colors.peach, fg = colors.base, bold = true },
    StCwdSep = { fg = colors.yellow, bg = colors.surface1 },
    StFileSep = { fg = colors.peach, bg = colors.surface1 },
    StDirFileSep = { fg = colors.yellow, bg = colors.peach },
    -- Git stuffs
    StGitBranch = { bg = colors.overlay0, fg = colors.mauve },
    StGitAdded = { bg = colors.overlay0, fg = colors.green },
    StGitChanged = { bg = colors.overlay0, fg = colors.yellow },
    StGitRemoved = { bg = colors.overlay0, fg = colors.red },
    StGitSep = { bg = colors.surface1, fg = colors.overlay0 },
    -- LSP Stuffs
    -- StLSPProgress = { bg = vim.g.transparency and "NONE" or "statusline_bg", fg = "" },
    StLSPClient = { bg = colors.surface1, fg = colors.blue, bold = true },
    StLSPDiagSep = { bg = colors.surface1, fg = colors.overlay0 },
    StLSPErrors = { bg = colors.overlay0, fg = colors.red },
    StLSPWarnings = { bg = colors.overlay0, fg = colors.yellow },
    StLSPHints = { bg = colors.overlay0, fg = colors.mauve },
    StLspInfo = { bg = colors.overlay0, fg = colors.sky },
    -- Lsp Diagnostics
    DiagnosticHint = { fg = colors.mauve },
    DiagnosticError = { fg = colors.red },
    DiagnosticWarn = { fg = colors.yellow },
    DiagnosticInformation = { fg = colors.green },
    -- File Info stuffs
    StPosition = { bg = colors.sapphire, fg = colors.surface1 },
    StPositionSep = { bg = colors.surface1, fg = colors.sapphire },

    Parameter = { fg = colors.sky },

    ["@conceal.checked"] = { fg = colors.teal },
    ["@none"] = { link = "Normal" },
    ["@field"] = { fg = colors.blue },
    ["@comment.todo"] = { fg = colors.lavender },
    ["@property"] = { fg = colors.blue },
    ["@variable.member"] = { fg = colors.blue },
    ["@parameter"] = { fg = colors.sky },
    ["@comment.note"] = { link = "@comment.hint" },
    ["@lsp.type.annotation"] = { fg = colors.yellow },
    ["@lsp.type.modifier.java"] = { link = "@type.qualifier" },
    ["@lsp.mod.builtin"] = { fg = colors.maroon },
    ["@lsp.mod.readonly.python"] = { link = "Constant" },
    ["@lsp.mod.documentation"] = { bold = true, fg = colors.mauve },
    ["@lsp.type.keyword"] = { fg = colors.mauve },
    DiagnosticUnnecessary = { link = "" },

    -- General --
    Comment = { italic = true },
    Statement = { italic = true },
    Define = { italic = true },
    Include = { italic = true },
    Function = { italic = true },
    Keyword = { italic = true },
    SpecialComment = { italic = true },
    -- CursorLine = { bg = "statusline_bg" },
    Delimiter = { italic = true },
    FloatBorder = { link = "NormalFloat" },

    -- Treesitter --
    TSVariable = { italic = true },
    TSKeyword = { italic = true },
    TSMethod = { italic = true },
    TSDefine = { italic = true },
    ["@tag.attribute"] = { italic = true },
    ["@variable.parameter"] = { italic = true },
    ["@keyword"] = { italic = true },
    ["@tag"] = { bold = true },
    ["@function.call"] = { bold = true },
    ["@comment"] = { italic = true },
    eliixirString = { italic = true },

    -- Illuminate --
    IlluminatedWordWrite = { link = "Pmenu" },
    IlluminatedWordText = { link = "Pmenu" },
    IlluminatedWordRead = { link = "Pmenu" },

    -- Mini module --
    MiniPickMatchCurrent = { link = "PmenuExtraSel" },

    -- Flash --
    FlashLabel = { bg = "NvimLightGreen", bold = true, italic = true },
  }
end

return M
