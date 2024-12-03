local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local highlight = require "utils.highlight"

-- This command is necessary so we dont change the current active tab after resizing
autocmd({ "VimResized" }, {
  desc = "Auto resize panes when resizing nvim window",
  pattern = "*",
  command = [[
    let _auto_resize_current_tab = tabpagenr()
    tabdo wincmd =
    execute 'tabnext' _auto_resize_current_tab
  ]],
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
  pattern = "gitcommit,gitrebase,text,markdown,copilot-chat",
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
  desc = "Treat slim files as ruby files",
  pattern = { "*.slim" },
  command = [[setfiletype ruby]],
})

autocmd("FileType", {
  desc = "Set formatprg to jq for json files",
  pattern = { "json" },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
  end,
})

autocmd("FileType", {
  desc = "Enable spell checking for markdown files",
  pattern = { "markdown" },
  command = "setlocal spell",
})
