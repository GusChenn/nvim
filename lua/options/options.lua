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

-- Re-enable python provier (disabled by nvchad)
-- g.loaded_python3_provider = 1
-- g.python3_host_prog = "/usr/bin/python3"

g.VtrPercentage = 50
g.VtrOrientation = "h"
g.VtrClearBeforeSend = 0

-- nvim ufo default settings
o.foldcolumn = "0"
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Removed this because im using ufo
o.foldmethod = "expr"
o.foldlevelstart = 99
o.foldenable = true
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
o.cursorline = true
o.cursorlineopt = "both" -- to enable cursorline!
opt.guicursor = {
  "n-sm:block",
  "v:hor50",
  "c-cr:ver10",
  "ci:ver10",
  "ve:ver10",
  "i:block-Cursor/lCursor", -- Changed insert mode to block
  "o-r:hor10",
  "a:Cursor/Cursor-blinkwait0-blinkon0-blinkoff0",
}

-- WARNING: AI SLOP --------------------------------------------------------------------------
-- Define custom cursor color for insert mode
-- Create an autocommand group for cursor settings
local cursor_group = vim.api.nvim_create_augroup("CursorSettings", { clear = true })

-- Store original cursor color
local original_cursor_color = nil

-- Capture original cursor color on startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = cursor_group,
  callback = function()
    -- Get cursor highlight attributes
    local hl = vim.api.nvim_get_hl(0, { name = "Cursor" })
    original_cursor_color = hl.bg or hl.fg or "#ffffff"
  end,
  once = true,
})

-- Set cursor appearance based on mode
vim.api.nvim_create_autocmd("ModeChanged", {
  group = cursor_group,
  pattern = "*:*",
  callback = function()
    local new_mode = vim.fn.mode()
    if new_mode == "i" or new_mode == "ic" then
      vim.api.nvim_set_hl(0, "Cursor", { link = "CurSearch" })
    else
      -- Other modes: restore original cursor
      if original_cursor_color then
        vim.api.nvim_set_hl(0, "Cursor", { bg = original_cursor_color })
      end
    end
    -- Force cursor update by scheduling a redraw
    vim.schedule(function()
      vim.cmd "redraw"
    end)
  end,
})

-- Also handle ColorScheme events
vim.api.nvim_create_autocmd("ColorScheme", {
  group = cursor_group,
  callback = function()
    -- Update original cursor color
    local hl = vim.api.nvim_get_hl(0, { name = "Cursor" })
    original_cursor_color = hl.bg or hl.fg or "#ffffff"

    -- Reapply cursor color based on current mode
    local mode = vim.fn.mode()
    if mode == "i" or mode == "ic" then
      vim.api.nvim_set_hl(0, "Cursor", { link = "CurSearch" })
    end
    -- Force redraw
    vim.cmd "redraw"
  end,
})
-- WARNING: AI SLOP END  --------------------------------------------------------------------------

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
opt.shortmess:append "sI"

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
