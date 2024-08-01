return {
  view = {
    width = 60,
    side = "right",
    preserve_window_proportions = true,
  },
  filters = {
    enable = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  git = {
    enable = true,
    ignore = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    highlight_opened_files = "none",

    indent_markers = {
      enable = true,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },

      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"

    -- Load default mappings
    api.config.mappings.default_on_attach(bufnr)
    require("which-key").add {
      { "h", api.node.navigate.parent_close, buffer = bufnr, desc = "Close", },
      { "l", api.node.open.edit,             buffer = bufnr, desc = "Open", },
    }
  end,
}
