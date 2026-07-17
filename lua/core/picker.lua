vim.pack.add({
  {
    src = 'https://github.com/nvim-mini/mini.pick',
    version = 'stable',
  },
})

require("mini.pick").setup()

-- vim.keymap.set("n", "ff", MiniPick.builtin.files, { desc = "Find files" })
vim.keymap.set('n', 'fg', MiniPick.builtin.grep_live, { desc = 'Live grep' })
vim.keymap.set('v', 'fg', function()
  local save, save_type = vim.fn.getreg('z'), vim.fn.getregtype('z')

  vim.cmd('noautocmd normal! "zy')
  local chars = vim.fn.split(vim.fn.getreg('z'), '\\zs')

  vim.fn.setreg('z', save, save_type)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniPickStart',
    once = true,
    callback = function() MiniPick.set_picker_query(chars) end,
  })
  MiniPick.builtin.grep_live()
end, { desc = 'Live grep selection' })

vim.keymap.set("n", "fb", MiniPick.builtin.buffers, { desc = "List open buffers" })


local smart_pick = require('core.custom_pickers.smart_pick')

smart_pick.setup()
vim.keymap.set('n', 'ff', smart_pick.picker)
