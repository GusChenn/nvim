require("neo-tree").setup({
	close_if_last_window = true,
	window = {
		mappings = {
			["C"] = "close_all_subnodes",
			["Z"] = "expand_all_nodes",
		},
		position = "left",
		width = 70,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
		hijack_netrw_behavior = "open_current",
	},
	filtered_items = {
		visible = true,
		show_hidden_count = true,
		hide_dotfiles = false,
		hide_gitignored = false,
		hide_by_name = {
			-- '.git',
			-- '.DS_Store',
			-- 'thumbs.db',
		},
		never_show = {},
	},
})
