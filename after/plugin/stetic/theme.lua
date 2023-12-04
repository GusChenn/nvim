-- Dracula config
--
-- local status, dracula = pcall(require, "dracula")
-- if not status then
-- 	print("Somthing went wrong with dracula")
-- 	return
-- end

-- dracula.setup({
-- 	show_end_of_buffer = false,
-- 	italic_comment = true,
-- })

-- local function update_hl(group, tbl)
-- 	local old_hl = vim.api.nvim_get_hl_by_name(group, true)
-- 	local new_hl = vim.tbl_extend("force", old_hl, tbl)
-- 	vim.api.nvim_set_hl(0, group, new_hl)
-- end

-- -- List of elements i want to forçe italic so it looks good with VictorMono
-- update_hl("@tag.attribute.tsx", { italic = true, fg = "#bd93f9" })
-- -- update_hl('@string.tsx', { italic = true, fg = "#f1fa8c" })
-- -- update_hl('@property.tsx', { italic = true, fg = "#bd93f9" })
-- update_hl("@type.tsx", { italic = true, fg = "#a4ffff" })

-- vim.cmd([[colorscheme dracula]])

-- Catppuccin setup

local hour_of_the_day = tonumber(os.date("%H"))

local function define_theme()
	if hour_of_the_day <= 17 then
		return "latte"
	else
		return "mocha"
	end
end

require("catppuccin").setup({
	flavour = define_theme(), -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		lsp_saga = true,
		harpoon = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
