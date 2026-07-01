function _G.simple_foldtext()
  return vim.fn.getline(vim.v.foldstart):gsub("%s+$", "") .. "..."
end

vim.opt.foldtext = "v:lua.simple_foldtext()"
