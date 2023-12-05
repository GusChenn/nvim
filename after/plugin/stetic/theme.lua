local alacritty_color_matcher = require("user.alacritty-color-matcher")

-- Catppuccin setup

local hour_of_the_day = tonumber(os.date("%H"))

local function define_theme()
	if hour_of_the_day < 17 then
		return "latte"
	else
		return "macchiato"
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

if not alacritty_color_matcher then
	return
end

-- Add autocmd to invoke add_alacritty_bg_lines on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		alacritty_color_matcher.add_alacritty_bg_lines()
	end,
})

-- Add autocmd to invoke remove_alacritty_bg_lines on exit
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	callback = function()
		alacritty_color_matcher.remove_alacritty_bg_lines()
	end,
})
