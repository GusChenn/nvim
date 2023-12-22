local helpers = require("user.helpers")
local harpoon = helpers.SafeRequire("harpoon")

if not harpoon then
	return
end

local format_list_item = function(list_item)
	-- return only the part after the last / character on the path
	if not list_item.value:match("^.+/(.+)$") then
		return "-- delete me or else i will explode --"
	else
		return " " .. list_item.value:match("^.+/(.+)$")
	end
end

harpoon:setup({
	settings = {
		save_on_toggle = true,
	},
	default = {
		display = format_list_item,
	},
})

-- Set keymaps

vim.keymap.set("n", "<leader>pp", function()
	harpoon:list():append()
end)

-- to open quick menu
vim.keymap.set("n", "<leader>p", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

-- To open telescope preview
-- vim.api.nvim_set_keymap("n", "<leader>p", ":Telescope harpoon marks<CR>", { noremap = true, silent = true })
--
vim.keymap.set("n", "<leader>l", function()
	harpoon:list():next()
end)

vim.keymap.set("n", "<leader>h", function()
	harpoon:list():prev()
end)
