local opt = vim.opt
local o = vim.o

opt.fillchars = {
  vert = " ",
  eob = " ",
  foldclose = "▶",
  foldopen = "▼",
  fold = " ",
  foldsep = " ", -- blank instead of the default "│" so the foldcolumn only shows arrows, no vertical lines
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

vim.opt.showbreak = "~ "

opt.signcolumn = "yes"
vim.opt.foldlevelstart = 99
