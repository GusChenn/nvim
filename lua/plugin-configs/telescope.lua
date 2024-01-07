local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

local base_mappings = {
  i = {
    ["<C-n>"] = telescope_actions.cycle_history_next,
    ["<C-p>"] = telescope_actions.cycle_history_prev,
    ["<C-j>"] = telescope_actions.move_selection_next,
    ["<C-k>"] = telescope_actions.move_selection_previous,
    ["<c-t>"] = trouble.open_with_trouble,
    ["<C-h>"] = "which_key",
  },
}

telescope.setup({
	defaults = {
		mappings = {
			i = base_mappings,
			n = base_mappings,
		},
	},
})
