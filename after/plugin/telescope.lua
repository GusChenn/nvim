local status, telescope = pcall(require, 'telescope')
if (not status) then
    print("Somthing went wrong with telescope")
    return
end

local telescope_previewers = require('telescope.previewers')

telescope.setup {
    defaults = {
    --     Cheatsheet plugin cant handle flex yet
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                preview_cutoff = 0,
            },
        },
        file_previewer = telescope_previewers.vim_buffer_cat.new,
	    grep_previewer = telescope_previewers.vim_buffer_vimgrep.new,
	    qflist_previewer = telescope_previewers.vim_buffer_qflist.new,
    },
    -- pickers = {
    --     find_files = {
    --         theme = "dropdown"
    --     },
    -- },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

telescope.load_extension('fzf')
