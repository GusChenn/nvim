local wc = require "which-key"
local cmd = require("utils.plugin-helpers").cmd

local safe_close = function()
  local is_buffer_in_multiple_splits = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local windows = vim.api.nvim_list_wins()
    local count = 0
    for _, win in ipairs(windows) do
      if vim.api.nvim_win_get_buf(win) == current_buf then
        count = count + 1
      end
    end
    return count > 1
  end

  if is_buffer_in_multiple_splits() then
    vim.cmd "q"
  else
    vim.cmd "bd"
  end
end

local close_all_buffers = function()
  vim.cmd "CleanBuffers"
  vim.cmd "bd!"
end

local toggle_line_numbers = function()
  if vim.wo.number == true then
    vim.wo.number = false
  else
    vim.wo.number = true
  end
end

wc.add {
  { "<leader>n",  toggle_line_numbers,     desc = "Toggle line numbers" },
  { "<leader>s",  "*",                     desc = "Highligh all instances of the word under the cursor" },
  { "<leader>q",  safe_close,              desc = "Close buffer safely" },
  { "<leader>Q",  cmd "qa!",               desc = "Quit nvim" },
  { "<leader>wh", cmd "split",             desc = "Split window horizontally" },
  { "<leader>wv", cmd "vsplit",            desc = "Split window vertically" },
  { "J",          ":m '>+1<CR>gv=gv",      mode = "v",                                                  desc = "Move line down respecting indentation" },
  { "K",          ":m '<-2<CR>gv=gv",      mode = "v",                                                  desc = "Move line up respecting indentation" },
  { "s",          "0",                     mode = "v",                                                  desc = "Move to the beginning of the line" },
  { "S",          "$",                     mode = "v",                                                  desc = "Move to the end of the line" },
  { "<C-q>",      cmd "noautocmd w",       desc = "Save file without autocmds" },
  { "cb",         close_all_buffers,       desc = "Close all buffers except the current one" },
  { "<C-l>",      cmd "noh",               desc = "Clear highlights" },
  { "Y",          '"+y',                   mode = "v",                                                  desc = "Copy to system clipboard" },
  { "<C-s>",      cmd "w",                 desc = "Save file with autocmds" },
  { "<A-k>",      cmd "TmuxNavigateUp",    desc = "Focus pane up" },
  { "<A-j>",      cmd "TmuxNavigateDown",  desc = "Focus pane down" },
  { "<A-h>",      cmd "TmuxNavigateLeft",  desc = "Focus pane left" },
  { "<A-l>",      cmd "TmuxNavigateRight", desc = "Focus pane right" },
  { "cpp",
    function()
      local path = vim.fn.expand "%:."
      vim.fn.setreg("+", path)
    end,
    desc = "Copies the current file path to the clipboard",
  },
  { "spp",
    function()
      local path = vim.fn.expand "%:."
      vim.notify('Path: "' .. path)
    end,
    desc = "Shows the current file path",
  },
}
