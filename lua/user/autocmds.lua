local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ "VimResized" }, {
  desc = "Auto resize panes when resizing nvim window",
  pattern = "*",
  group = augroup("VimResizedGroup", {}),
  command = [[
	let _auto_resize_current_tab = tabpagenr()
	tabdo wincmd =
	execute 'tabnext' _auto_resize_current_tab
	]],
})

autocmd({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  callback = function()
    local hlgroup = "Substitute"
    local timeout = 200
    vim.hl.on_yank { higroup = hlgroup, timeout = timeout }
  end,
  group = augroup("HightlightOnYankGroup", {}),
})

autocmd('FileType', {
  pattern = { 'qf' },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>cclose<cr>', { silent = true, buffer = true })
  end,
})
