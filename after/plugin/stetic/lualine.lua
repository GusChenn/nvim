local status, lualine = pcall(require, "lualine")
local lspsaga_winbar = require("lspsaga.symbol.winbar")

if not status and lspsaga_winbar then
	return
end

local function get_bar_text()
	return lspsaga_winbar.get_bar()
end

-- Return the theme name if current theme is allowed
local function check_theme_name()
	local theme = vim.g.colors_name

	local lualine_supported_themes = {
		"catppuccino",
		"melange",
	}

	for _, supported_theme in ipairs(lualine_supported_themes) do
		if theme == supported_theme then
			return theme
		end
	end

	return nil
end

---@diagnostic disable-next-line: undefined-field
lualine.setup({
	options = {
		icons_enabled = true,
		theme = check_theme_name(),
		component_separators = { left = " ", right = " " },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "NvimTree", "terminal" },
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			get_bar_text,
		},
		lualine_x = { "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
