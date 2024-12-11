vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_cursor = "auto"

-- Set some custom HLs
vim.api.nvim_set_hl(0, "@type.ruby", { link = "Yellow" })
vim.api.nvim_set_hl(0, "Visual", { fg = "#e78a4e", bg = "#3c3836" })
