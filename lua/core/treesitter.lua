vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

require('nvim-treesitter').setup({
  ensure_installed = { 'lua', 'ruby', 'python', 'javascript', 'typescript', 'html', 'css', 'json', 'yaml', 'markdown' },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'ruby', 'python', 'javascript', 'typescript', 'html', 'css', 'json', 'yaml', 'markdown' },
  callback = function()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
  end
})
