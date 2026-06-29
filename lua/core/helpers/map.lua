local cmd = function(cmd)
	return string.format("<CMD> %s <CR>", cmd)
end

local map = function(mode, lhs, rhs, opts)
	opts = opts or {}

	if type(rhs) == "string" then
		rhs = cmd(rhs)
	end
	vim.keymap.set(mode, lhs, rhs, opts)
end

return map
