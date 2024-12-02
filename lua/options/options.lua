-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

local opt = vim.opt
local g = vim.g
local o = vim.o
local wo = vim.wo

-- Personal global vars
g.quickfix_context_expanded = false
g.copilot_chat_loaded = false

-- General globals

g.mapleader = " "
g.maplocalleader = "\\"

g.tmux_navigator_no_mappings = 1
g.matchup_matchparen_offscreen = {}
g.lastplace_ignore = "gitcommit,gitrebase,hgcommit,svn,xxd"
g.lastplace_ignore_buftype = "help,nofile,quickfix"

-- Re-enable python provier (disabled by nvchad)
-- g.loaded_python3_provider = 1
-- g.python3_host_prog = "/usr/bin/python3"

g.VtrPercentage = 50
g.VtrOrientation = "h"
g.VtrClearBeforeSend = 0

-- nvim ufo default settings
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.foldcolumn = "0"
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
o.cursorline = true
o.cursorlineopt = "both" -- to enable cursorline!

-- hide fold column
o.showtabline = 0 -- to hide tabline

o.laststatus = 3
o.showmode = false

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.undofile = true

vim.o.background = "dark"

opt.linebreak = true
opt.showbreak = ">>"
opt.breakindent = true
opt.timeoutlen = 200
opt.scrolloff = 999
opt.clipboard = ""
opt.fillchars = {
  vert = " ",
  eob = " ",
}
opt.conceallevel = 2

wo.number = false

-- Set shell
-- vim.api.nvim_set_option("shell", "/usr/bin/zsh")

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
