local nvterm = require("nvterm")
local nvterm_terminal = require("nvterm.terminal")

nvterm.setup({
	terminals = {
		shell = vim.o.shell,
		list = {},
		type_opts = {
			float = {
				relative = "editor",
				row = 0.3,
				col = 0.25,
				width = 0.5,
				height = 0.4,
				border = "single",
			},
			horizontal = { location = "rightbelow", split_ratio = 0.3 },
			vertical = { location = "rightbelow", split_ratio = 0.5 },
		},
	},
	behavior = {
		autoclose_on_quit = {
			enabled = false,
			confirm = true,
		},
		close_on_exit = true,
		auto_insert = true,
	},
})

local ucmd = vim.api.nvim_create_user_command

-- Create command to run scripts
ucmd("RunScript", function()
	local path = vim.fn.expand("%:.")
	local command = "qr console run " .. path
	nvterm_terminal.send(command, "vertical")
end, {})

ucmd("RunScriptCsv", function()
	local path = vim.fn.expand("%:.")
	local command = "qr console run " .. path .. " --large > temp_planilha.csv"
	nvterm_terminal.send(command, "vertical")
end, {})

ucmd("Storybook", function()
	local path = vim.fn.expand("%:.")
	local command = "nocorrect yarn storybook " .. path
	nvterm_terminal.send(command, "vertical")
end, {})

ucmd("FullSpec", function()
	local path = vim.fn.expand("%:.")
	local command = "nocorrect RUBYOPT='-W:deprecated' RAISE_DEPRECATIONS=true NOTIFY_DEPRECATION_WARNINGS=true bundle exec rspec "
		.. path
	nvterm_terminal.send(command, "vertical")
end, {})

ucmd("Spec", function()
	local path = vim.fn.expand("%:.")
	local cursor_y, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local command = "nocorrect RUBYOPT='-W:deprecated' RAISE_DEPRECATIONS=true NOTIFY_DEPRECATION_WARNINGS=true bundle exec rspec "
		.. path
		.. ":"
		.. cursor_y
	nvterm_terminal.send(command, "vertical")
end, {})
