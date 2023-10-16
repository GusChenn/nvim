---@diagnostic disable: need-check-nil
local function safe_require(package_name)
  local status, package = pcall(require, package_name)
  if (not status) then
      print("Somthing went wrong with" .. package_name)
      return
  end 
  return package
end

local telescope = safe_require('telescope')
local telescope_actions = safe_require('telescope.actions')
local telescope_previewers = safe_require('telescope.previewers')

local opts = { nowait = true, silent = true }

telescope.setup {
    defaults = {
    --     Cheatsheet plugin cant handle flex yet
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                preview_cutoff = 0,
            },
        },
        file_previewer = telescope_previewers and telescope_previewers.vim_buffer_cat.new,
        grep_previewer = telescope_previewers and telescope_previewers.vim_buffer_vimgrep.new,
        qflist_previewer = telescope_previewers and telescope_previewers.vim_buffer_qflist.new,
    },
    pickers = {
        find_files = {
          mappings = {
            i = {
              ["<C-j>"] = telescope_actions.move_selection_next,
              ["<C-k>"] = telescope_actions.move_selection_previous,
              ["<ESC>"] = telescope_actions.close,
            }
          }
        },
        live_grep = {
          mappings = {
            i = {
              ["<C-j>"] = telescope_actions.move_selection_next,
              ["<C-k>"] = telescope_actions.move_selection_previous,
              ["<ESC>"] = telescope_actions.close,
            }
          }
        }
    },
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
