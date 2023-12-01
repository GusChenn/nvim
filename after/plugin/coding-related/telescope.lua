local helpers = require("user.helpers")
local telescope = helpers.SafeRequire("telescope")
local telescope_actions = helpers.SafeRequire("telescope.actions")
local telescope_previewers = helpers.SafeRequire("telescope.previewers")

if not (telescope and telescope_actions and telescope_previewers) then
	return
end

local base_mappings = {
	i = {
		["<C-n>"] = telescope_actions.cycle_history_next,
		["<C-p>"] = telescope_actions.cycle_history_prev,
		["<C-j>"] = telescope_actions.move_selection_next,
		["<C-k>"] = telescope_actions.move_selection_previous,
		-- ["<ESC>"] = telescope_actions.close,
	},
}

telescope.setup({
	defaults = {
		--     Cheatsheet plugin cant handle flex yet
		layout_strategy = "horizontal",
		layout_config = {
			vertical = {
				preview_cutoff = 0,
			},
		},
	},
	pickers = {
		find_files = {
			mappings = base_mappings,
		},
		live_grep = {
			mappings = base_mappings,
		},
		oldfiles = {
			mappings = base_mappings,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("harpoon")
