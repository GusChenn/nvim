local status, dracula = pcall(require, 'dracula')
if (not status) then
  print("Somthing went wrong with dracula")
  return
end

dracula.setup {
  show_end_of_buffer = false,
  italic_comment = true,
}

local function update_hl(group, tbl)
	local old_hl = vim.api.nvim_get_hl_by_name(group, true)
	local new_hl = vim.tbl_extend('force', old_hl, tbl)
	vim.api.nvim_set_hl(0, group, new_hl)
end

-- List of elements i want to forçe italic so it looks good with VictorMono
update_hl('@tag.attribute.tsx', { italic = true, fg = "#bd93f9" })
-- update_hl('@string.tsx', { italic = true, fg = "#f1fa8c" })
-- update_hl('@property.tsx', { italic = true, fg = "#bd93f9" })
update_hl('@type.tsx', { italic = true, fg = "#a4ffff" })


vim.cmd[[colorscheme dracula]]
