local opt = vim.opt
local o = vim.o

opt.fillchars = {
  vert = " ",
  eob = " ",
  foldclose = "▶",
  foldopen = "▼",
  fold = " ",
}

o.cursorline = true
o.cursorlineopt = "screenline,number"
o.autocomplete = false

opt.scrolloff = 999
opt.clipboard = "unnamedplus"

opt.timeoutlen = 300

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

opt.splitright = true
opt.splitbelow = true

opt.signcolumn = "yes"
opt.foldcolumn = "auto:9"
vim.opt.foldlevelstart = 99
