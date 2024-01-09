local user_highlights = require("user.utils.telescope-custom-highlights.highlight-values")
local set_hl = vim.api.nvim_set_hl

for group, highlights in pairs(user_highlights) do
	set_hl(0, tostring(group), highlights)
end
