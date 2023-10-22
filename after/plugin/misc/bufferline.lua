---@diagnostic disable: missing-fields
local status, bufferline = pcall(require, "bufferline")
if not status then
	print("Somthing went wrong with bufferline")
	return
end

bufferline.setup({
	options = {
		style_preset = {
			bufferline.style_preset.minimal,
			-- bufferline.style_preset.no_italic,
			-- bufferline.style_preset.no_bold,
		},
		themable = true,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
			return "" .. icon .. " " .. count
		end,
		separator_style = "slant",
		highlights = {
			fill = {
				fg = "#738219",
				bg = "#738219",
			},
			background = {
				fg = "#738219",
				bg = "#738219",
			},
			tab_selected = {
				bg = "#090909",
				fg = "#090909",
			},
			tab_separator = {
				bg = "#f981a3",
				fg = "#f981a3",
			},
			separator_selected = {
				bg = "#f981a3",
				fg = "#f981a3",
			},
			offset_separator = {
				bg = "#f981a3",
				fg = "#f981a3",
			},
		},
	},
})
