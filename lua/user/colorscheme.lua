local colorscheme = "dracula"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- [[ Personal configs ]]
vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
vim.cmd [[highlight SignColumn guibg=none ctermbg=NONE]]
vim.cmd [[highlight FloatBorder guifg=white ctermfg=white]]
vim.cmd [[highlight NormalFloat guibg=NONE ctermbg=NONE]]

