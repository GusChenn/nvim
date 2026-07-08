function _G.tabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = buflist[winnr]

    local bufname = vim.fn.bufname(bufnr)
    if bufname == "" then
      bufname = "[No Name]"
    else
      bufname = vim.fn.fnamemodify(bufname, ":t")
    end

    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    s = s .. " " .. bufname .. " "
  end
  s = s .. "%#TabLineFill#"
  return s
end

vim.opt.tabline = "%!v:lua.tabline()"

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE", fg = "NONE" })
