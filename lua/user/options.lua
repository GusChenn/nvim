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

opt.scrolloff = 999
opt.clipboard = "unnamedplus"

opt.timeoutlen = 200

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

opt.splitright = true
opt.splitbelow = true

opt.signcolumn = "yes"
opt.foldcolumn = "2"

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    target = "msg",
  }
})
