local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local highlight = require "utils.highlight"

autocmd({ "VimResized" }, {
  desc = "Auto resize panes when resizing nvim window",
  pattern = "*",
  command = "tabdo wincmd =",
})

autocmd({ "BufEnter" }, {
  desc = "Auto resize panes when entering copilot-chat",
  pattern = "copilot-chat",
  command = "tabdo wincmd =",
})

autocmd({ "FileType" }, {
  desc = "Disable cmp in certain filetypes",
  pattern = "gitcommit,gitrebase,text,markdown",
  command = "lua require('cmp').setup.buffer { enabled = false}",
  group = augroup("cmp_disable", { clear = true }),
})

autocmd({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  callback = highlight.on_yank,
  group = vim.api.nvim_create_augroup("highlight", {}),
})

autocmd({ "FileType" }, {
  desc = "Close quick fix list after selecting a element",
  pattern = "qf",
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

autocmd({ "FileType" }, {
  desc = "Close quick fix list with q",
  pattern = "qf",
  command = [[nnoremap <buffer> q <CR>:cclose<CR>]],
})

autocmd({ "BufRead" }, {
  desc = "Treat slim files as ruby files",
  pattern = "*.slim",
  command = [[setfiletype ruby]],
})

autocmd({ "FileType" }, {
  desc = "Make vim not trigger an auto indent when typing a dot on ruby files",
  pattern = { "ruby", "*.slim" },
  command = "setlocal indentkeys-=.",
})

autocmd({ "BufEnter" }, {
  desc = "Close diffview with 'q'",
  pattern = { "DiffviewFilePanel", "diffview://*" },
  callback = function()
    vim.keymap.set("n", "q", "<CMD> DiffviewClose <CR>", { buffer = true })
  end,
})
