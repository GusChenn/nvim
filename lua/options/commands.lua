local usercmd = vim.api.nvim_create_user_command

usercmd("CleanBuffers", ":%bd!", {})

usercmd("RunScript", function()
	local path = vim.fn.expand("%:.")
	local command = "qr console run " .. path
	vim.cmd("VtrAttachToPane")
	vim.cmd("VtrSendCommandToRunner " .. command)
end, {})

usercmd("RunScriptCsv", function()
	local path = vim.fn.expand("%:.")
	local command = "qr console run " .. path .. " --large > temp_planilha.csv"
	vim.cmd("VtrAttachToPane")
	vim.cmd("VtrSendCommandToRunner " .. command)
end, {})

usercmd("Storybook", function()
	local path = vim.fn.expand("%:.")
	local command = "nocorrect yarn storybook " .. path
	vim.cmd("VtrAttachToPane")
	vim.cmd("VtrSendCommandToRunner " .. command)
end, {})

usercmd("FullSpec", function()
	local path = vim.fn.expand("%:.")
	local command = "nocorrect RUBYOPT='-W:deprecated' RAISE_DEPRECATIONS=true NOTIFY_DEPRECATION_WARNINGS=true bundle exec rspec "
		.. path
	vim.cmd("VtrAttachToPane")
	vim.cmd("VtrSendCommandToRunner " .. command)
end, {})

usercmd("Spec", function()
	local path = vim.fn.expand("%:.")
	local cursor_y, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local command = "nocorrect RUBYOPT='-W:deprecated' RAISE_DEPRECATIONS=true NOTIFY_DEPRECATION_WARNINGS=true bundle exec rspec "
		.. path
		.. ":"
		.. cursor_y
	vim.cmd("VtrAttachToPane")
	vim.cmd("VtrSendCommandToRunner " .. command)
end, {})
