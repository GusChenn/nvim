local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

local base_mappings = {
	["<C-n>"] = telescope_actions.cycle_history_next,
	["<C-p>"] = telescope_actions.cycle_history_prev,
	["<C-j>"] = telescope_actions.move_selection_next,
	["<C-k>"] = telescope_actions.move_selection_previous,
	["<c-t>"] = trouble.open_with_trouble,
	["<C-h>"] = "which_key",
}

telescope.setup({
	defaults = {
		mappings = {
			i = base_mappings,
			n = base_mappings,
		},
		--     Cheatsheet plugin cant handle flex yet
		layout_strategy = "horizontal",
		borderchars = {
			{ " ", " ", " ", " ", " ", " ", " ", " " },
			prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
			result = { " ", " ", " ", " ", " ", " ", " ", " " },
			preview = { " ", " ", " ", " ", " ", " ", " ", " " },
		},
		prompt_prefix = "   ",
		entry_prefix = " 󰇊  ",
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

telescope.load_extension("projects")
