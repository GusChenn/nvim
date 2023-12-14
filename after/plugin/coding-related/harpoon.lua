local helpers = require("user.helpers")
local harpoon = helpers.SafeRequire("harpoon")

if not harpoon then
	return
end

harpoon:setup({})

-- Set keymaps

vim.keymap.set("n", "<leader>pp", function()
	harpoon:list():append()
end)
vim.keymap.set("n", "<leader>p", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<leader>l", function()
	harpoon:list():next()
end)
vim.keymap.set("n", "<leader>h", function()
	harpoon:list():prev()
end)
