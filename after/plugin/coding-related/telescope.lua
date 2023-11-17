local helpers = require("user.helpers")
local telescope = helpers.SafeRequire("telescope")
local telescope_actions = helpers.SafeRequire("telescope.actions")
local telescope_previewers = helpers.SafeRequire("telescope.previewers")

if not (telescope and telescope_actions and telescope_previewers) then
	return
end

telescope.setup({
	defaults = {
		--     Cheatsheet plugin cant handle flex yet
		layout_strategy = "horizontal",
		layout_config = {
			vertical = {
				preview_cutoff = 0,
			},
		},
		-- file_previewer = telescope_previewers.vim_buffer_cat.new,
		-- grep_previewer = telescope_previewers.vim_buffer_vimgrep.new,
		-- qflist_previewer = telescope_previewers.vim_buffer_qflist.new,
	},
	pickers = {
		find_files = {
			mappings = {
				i = {
					["<C-n>"] = telescope_actions.cycle_history_next,
					["<C-p>"] = telescope_actions.cycle_history_prev,
					["<C-j>"] = telescope_actions.move_selection_next,
					["<C-k>"] = telescope_actions.move_selection_previous,
					-- ["<ESC>"] = telescope_actions.close,
				},
			},
		},
		live_grep = {
			mappings = {
				i = {
					["<C-n>"] = telescope_actions.cycle_history_next,
					["<C-p>"] = telescope_actions.cycle_history_prev,
					["<C-j>"] = telescope_actions.move_selection_next,
					["<C-k>"] = telescope_actions.move_selection_previous,
					-- ["<ESC>"] = telescope_actions.close,
				},
			},
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
