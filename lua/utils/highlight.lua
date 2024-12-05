local highlight = {}

highlight.on_yank = function()
  local hlgroup = "IncSearch"
  local timeout = 100
  vim.highlight.on_yank { higroup = hlgroup, timeout = timeout }
end

return highlight
