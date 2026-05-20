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

-- enable undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

g.tmux_navigator_no_mappings = 1
g.matchup_matchparen_offscreen = {}
g.lastplace_ignore = "gitcommit,gitrebase,hgcommit,svn,xxd"
g.lastplace_ignore_buftype = "help,nofile,quickfix"

-- Setup python provider (use venv on ~/.global_venvs/nvim)
-- g.loaded_python3_provider = 1
-- g.python3_host_prog = vim.fn.expand "~/.global_venvs/nvim"

g.VtrPercentage = 50
g.VtrOrientation = "h"
g.VtrClearBeforeSend = 0

opt.fillchars = {
  vert = " ",
  eob = " ",
  foldclose = "▶", -- For closed folds
  foldopen = "▼", -- For open folds
  fold = " ", -- For the rest of the fold column
}

-- Setup statuscol
------------------------------------------------------
local fcs = vim.opt.fillchars:get()

local function get_fold(lnum)
  if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
    return " "
  end
  return vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
end

_G.get_statuscol = function()
  return "%s%l " .. get_fold(vim.v.lnum) .. " "
end

vim.o.statuscolumn = "%!v:lua.get_statuscol()"
------------------------------------------------------

-- Setup foldtext
------------------------------------------------------
local function find_any_substring(main_string, substrings)
  for _, sub in ipairs(substrings) do
    if string.find(main_string, sub, 1, true) then
      return true
    end
  end
  return false
end

_G.get_fold_text = function()
  local text = vim.fn.getline(vim.v.foldstart)

  if find_any_substring(text, { "{", "[" }) then
    local next_line = vim.fn.getline(vim.v.foldstart + 1):gsub("^%s+", "")
    text = text .. " " .. next_line
  end

  local fold_size = vim.v.foldend - vim.v.foldstart
  local line_count_text = string.format(" ↘ %d lines", fold_size)

  return text .. line_count_text
end

-- Then, set the foldtext option
o.foldtext = "v:lua.get_fold_text()"
------------------------------------------------------

-- nvim default settings
o.foldcolumn = "1"
o.foldlevel = 10
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldmethod = "expr"
o.foldlevelstart = 10
o.foldenable = true
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
o.cursorline = true
o.cursorlineopt = "both" -- to enable cursorline!
opt.guicursor = {
  "n-sm:block",
  "v:hor50",
  "c-cr:block", -- Use a block cursor in command-line mode
  "ci:block", -- Use a block cursor in command-line insert mode
  "ve:ver10",
  "i:block-blinkon500-blinkoff250", -- Use a blinking block in insert mode
  "o-r:hor10",
  "a:Cursor/Cursor",
}

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
o.relativenumber = false
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sIA"

o.signcolumn = "yes"
o.synmaxcol = 1000
o.splitbelow = true
o.splitright = true
o.undofile = true

vim.o.background = "dark" -- dark or light

opt.linebreak = true
opt.showbreak = "󱞩 "
opt.breakindent = true
o.breakindentopt = "list:-1"
opt.timeoutlen = 200
opt.scrolloff = 999
opt.clipboard = "unnamedplus"
opt.conceallevel = 2

wo.number = false

opt.spell = false

-- Set shell
-- vim.api.nvim_set_option("shell", "/usr/bin/zsh")
