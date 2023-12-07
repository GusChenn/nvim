local M = {}

M.config_path = "~/.config/alacritty/alacritty.yml"

function M.add_alacritty_theme_lines(theme_path)
	local cmds = {}
	cmds[1] = string.format("echo 'import:' >> %s", M.config_path)
	cmds[2] = string.format("echo '  - %s' >> %s", theme_path, M.config_path)

	for _, cmd in ipairs(cmds) do
		os.execute(cmd)
	end
end

function M.get_bg(group)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), "bg")
end

function M.add_alacritty_bg_lines()
	local bg = M.get_bg("Normal")
	local cmds = {}
	cmds[1] = string.format("echo 'colors:' >> %s", M.config_path)
	cmds[2] = string.format("echo '  primary:' >> %s", M.config_path)
	cmds[3] = string.format("echo '    background: \"%s\"' >> %s", bg, M.config_path)

	for _, cmd in ipairs(cmds) do
		os.execute(cmd)
	end
end

function M.remove_alacritty_lines(line_quantity)
	local lines_to_be_removed = line_quantity
	local cmd = string.format("sed -i '$d' %s", M.config_path)

	for _ = 1, lines_to_be_removed do
		os.execute(cmd)
	end
end

return M
