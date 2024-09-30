local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local highlight = require "utils.highlight"

autocmd({ "VimResized" }, {
  desc = "Auto resize panes when resizing nvim window",
  pattern = "*",
  command = "tabdo wincmd =",
})

-- enable when using catppuccin theme
-- autocmd({ "BufEnter" }, {
--   desc = "Change background color for copilot-chat buffers",
--   pattern = "copilot-chat",
--   callback = function()
--     vim.api.nvim_set_hl(0, 'CopilotChatBg', { bg = '#f0f0f0' })
--     vim.wo.winhighlight = 'Normal:CopilotChatBg'
--   end,
--   group = augroup("copilot_chat_bg", { clear = true }),
-- })

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
  command = [[nnoremap <buffer> q <CMD>:cclose<CR>]],
})

autocmd({ "BufRead" }, {
  desc = "Treat slim and erb files as ruby files",
  pattern = { "*.slim" },
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

autocmd("FileType", {
  desc = "Set formatprg to jq for json files",
  pattern = { "json" },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = 'local' })
  end,
})

-- enable spell checking for markdown files
autocmd("FileType", {
  desc = "Enable spell checking for markdown files",
  pattern = { "markdown" },
  command = "setlocal spell",
})
