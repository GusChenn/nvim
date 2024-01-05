local helpers = require("user.helpers")
local neotree = helpers.SafeRequire("neo-tree")

if not neotree then
	return
end

neotree.setup({
	close_if_last_window = false,
	popup_border_style = "single",
	window = {
		position = "left",
		width = 70,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
	},
	filesystem = {
		filtered_items = {
			visible = true,
			show_hidden_count = true,
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_by_name = {
				-- '.git',
				-- '.DS_Store',
				-- 'thumbs.db',
			},
			never_show = {},
		},
	},
})
