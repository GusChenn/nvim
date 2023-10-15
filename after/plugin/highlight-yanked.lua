vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = vim.api.nvim_create_augroup('HIGHLIGHT_YANKED_TEXT', {}),
  callback = function()
    local highlight = require('vim.highlight')
    highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end
})
