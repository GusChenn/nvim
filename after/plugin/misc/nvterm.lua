local helpers = require("user.helpers")
local nvterm = helpers.SafeRequire("nvterm")
local nvterm_terminal = helpers.SafeRequire("nvterm.terminal")

if not (nvterm and nvterm_terminal) then
	return
end

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

-- Create command to run scripts
vim.api.nvim_create_user_command("RunScript", function()
	local path = vim.fn.expand("%:.")
	local command = "qr console run" .. path
	nvterm_terminal.send(command, "vertical")
end, {})

vim.api.nvim_create_user_command("RunScriptCsv", function()
	local path = vim.fn.expand("%:.")
	local command = "qr console run " .. path .. " --large > temp_planilha.csv"
	nvterm_terminal.send(command, "vertical")
end, {})

vim.api.nvim_create_user_command("Storybook", function()
	local path = vim.fn.expand("%:.")
	local command = "nocorrect yarn storybook " .. path
	nvterm_terminal.send(command, "vertical")
end, {})

vim.api.nvim_create_user_command("Spec", function()
	local path = vim.fn.expand("%:.")
	local command = "nocorrect RUBYOPT='-W:deprecated' RAISE_DEPRECATIONS=true NOTIFY_DEPRECATION_WARNINGS=true bundle exec rspec "
		.. path
	nvterm_terminal.send(command, "vertical")
end, {})
