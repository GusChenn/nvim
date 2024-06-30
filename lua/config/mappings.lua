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

wc.register {
  ["<leader>"] = {
    n = { toggle_line_numbers, "Toggle line numbers" },
    s = { "*", "Highligh all instances of the word under the cursor" },
    q = { safe_close, "Close buffer safely" },
    Q = { cmd "qa!", "Quit nvim" },
    w = {
      name = "Splitting",
      h = { cmd "split", "Split window horizontally" },
      v = { cmd "vsplit", "Split window vertically" },
    },
  },
  J = { mode = "v", ":m '>+1<CR>gv=gv", "Move line down respecting indentation" },
  K = { mode = "v", ":m '<-2<CR>gv=gv", "Move line up respecting indentation" },
  s = { mode = "v", "0", "Move to the beginning of the line" },
  S = { mode = "v", "$", "Move to the end of the line" },
  ["<C-q>"] = { cmd "noautocmd w", "Save file without autocmds" },
  cb = { close_all_buffers, "Close all buffers except the current one" },
  ["<C-l>"] = { cmd "noh", "Clear highlights" },
  Y = { mode = "v", '"+y', "Copy to system clipboard" },
  ["<C-s>"] = { cmd "w", "Save file with autocmds" },
  ["<A-k>"] = { cmd "TmuxNavigateUp", "Focus pane up" },
  ["<A-j>"] = { cmd "TmuxNavigateDown", "Focus pane down" },
  ["<A-h>"] = { cmd "TmuxNavigateLeft", "Focus pane left" },
  ["<A-l>"] = { cmd "TmuxNavigateRight", "Focus pane right" },
}
