local wc = require "which-key"
local cmd = require("utils.plugin-helpers").cmd

local toggle_case = function()
  -- Get the word under cursor
  local current_word = vim.fn.expand "<cword>"

  -- Determine if the word is in camel/pascal case or snake case
  local is_snake_case = current_word:find "_" ~= nil

  local new_word

  if is_snake_case then
    -- Convert from snake_case to camelCase
    new_word = current_word:gsub("_(%w)", function(c)
      return c:upper()
    end)
  else
    -- Convert from camelCase/PascalCase to snake_case
    new_word = current_word:gsub("(%u)", function(c)
      return "_" .. c:lower()
    end)
    -- Remove leading underscore if it exists
    new_word = new_word:gsub("^_", "")
  end

  -- Replace the word
  vim.fn.setreg("z", new_word)
  vim.cmd 'normal! viw"zp'
end

local type_today_date = function()
  local date = os.date "%Y-%m-%d"
  local time = os.date "%H:%M:%S"
  local formatted_date = string.format("%s %s", date, time)
  vim.cmd(string.format("normal! i%s", formatted_date))
end

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
  elseif vim.wo.diff then
    vim.rpcnotify(0, "Exit", 0)
  elseif vim.bo.buftype == "terminal" then
    vim.cmd "bdelete!"
  else
    vim.cmd "bd"
  end
end

local safe_vsplit = function()
  if vim.bo.buftype == "terminal" then
    vim.cmd "vnew"
  else
    vim.cmd "vsplit"
  end
end

local safe_split = function()
  if vim.bo.buftype == "terminal" then
    vim.cmd "new"
  else
    vim.cmd "split"
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

local copy_path = function()
  local path = vim.fn.expand "%:."
  vim.fn.setreg("+", path)
end

local copy_absolute_path = function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
end

local show_path = function()
  local path = vim.fn.expand "%:."
  vim.notify('Path: "' .. path)
end

local function save_smart()
  local uv = vim.uv or vim.loop
  local buf = 0
  local name = vim.api.nvim_buf_get_name(buf)

  -- Determine size (prefer on-disk size; fallback to buffer content)
  local size
  if name ~= "" then
    local stat = uv.fs_stat(name)
    if stat and stat.size then
      size = stat.size
    end
  end
  if not size then
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)
    local total = 0
    for i = 1, #lines do
      total = total + #lines[i]
    end
    if #lines > 0 then
      total = total + (#lines - 1) -- newline bytes
    end
    size = total
  end

  local threshold = 10 * 1024 -- 10 KiB
  if size > threshold then
    vim.cmd "noautocmd write"
    vim.notify(
      string.format("Wrote large file (%d bytes) without autocmds", size),
      vim.log.levels.INFO,
      { title = "SaveSmart" }
    )
  else
    vim.cmd "write"
  end
end

local function stop_diff_mode()
  if vim.wo.diff then
    vim.cmd "diffoff!"
  end
end

local function git_compare_file_to_main()
  local filepath = vim.fn.expand "%"
  local handle = io.popen("git show main:" .. filepath)
  local result = handle:read "*a"
  handle:close()
  if result == "" then
    vim.notify("No differences found between current file and main branch.", vim.log.levels.INFO)
  else
    local tempname = os.tmpname()
    local tempfile = io.open(tempname, "w")
    tempfile:write(result)
    tempfile:close()
    vim.cmd("vert diffsplit " .. tempname)
  end
end

local function set_search_register()
  vim.opt.hlsearch = true
  local word = vim.fn.expand "<cword>"
  vim.fn.setreg("/", "\\<" .. word .. "\\>")
end

wc.add {
  { "<leader>fd", git_compare_file_to_main, desc = "Compare current file to main" },
  { "<leader>ds", stop_diff_mode, desc = "stop_diff_mode" },
  { "<leader>n", toggle_line_numbers, desc = "Toggle line numbers" },
  { "<leader>s", set_search_register, desc = "Highligh all instances of the word under the cursor" },
  { "<leader>q", safe_close, desc = "Close buffer safely" },
  { "<leader>Q", cmd "wqa!", desc = "Quit nvim" },
  { "<leader>wh", safe_split, desc = "Split window horizontally" },
  { "<leader>wv", safe_vsplit, desc = "Split window vertically" },
  {
    "J",
    ":m '>+1<CR>gv=gv",
    mode = "v",
    desc = "Move line down respecting indentation",
  },
  {
    "K",
    ":m '<-2<CR>gv=gv",
    mode = "v",
    desc = "Move line up respecting indentation",
  },
  { "<A-q>", cmd "noautocmd w", desc = "Save file without autocmds" },
  { "<C-s>", cmd "w", desc = "Save file with autocmds" },
  { "<leader>w", save_smart, desc = "Save file with autocmds" },
  { "cb", close_all_buffers, desc = "Close all buffers except the current one" },
  { "<leader>l", cmd "noh", desc = "Clear highlights" },
  {
    "Y",
    '"+y',
    mode = "v",
    desc = "Copy to system clipboard",
  },
  { "cpp", copy_path, desc = "Copies the current file path to the clipboard" },
  { "cpa", copy_absolute_path, desc = "Copies the current file absolute path to the clipboard" },
  { "spp", show_path, desc = "Shows the current file path" },
  { "<leader>L", cmd "tabnext", desc = "Next tab" },
  { "<leader>H", cmd "tabprevious", desc = "Previous tab" },
  { "<leader>T", cmd "tabnew", desc = "New tab" },
  { "jk", "<ESC>", mode = "i", desc = "Quit insert mode with jk" },
  { "kj", "<ESC>", mode = "i", desc = "Quit insert mode with kj" },
  { "jk", "<c-\\><c-n>", mode = "t", desc = "Quit insert mode with jk" },
  { "kj", "<c-\\><c-n>", mode = "t", desc = "Quit insert mode with kj" },
  { "<C-n>", "<down>", mode = "t", desc = "Down on terminal mode" },
  { "<C-p>", "<up>", mode = "t", desc = "Up on terminal mode" },
  { "<leader>fs", "I# frozen_string_literal: true<CR><ESC>Doclass", desc = "Add frozen string magic comment" },
  { "<C-h>", "<C-o>h", mode = "i", desc = "Move left in insert mode" },
  { "<C-j>", "<C-o>j", mode = "i", desc = "Move down in insert mode" },
  -- { "<C-k>", "<C-o>k", mode = "i", desc = "Move up in insert mode" },
  { "<C-l>", "<C-o>l", mode = "i", desc = "Move right in insert mode" },
  { "<leader>cc", toggle_case, desc = "Toggle between camel case and snake case" },
  { "<leader>td", type_today_date, desc = "Type todays date" },
  { "<leader><tab>", "za", mode = "n", desc = "Toggle fold" },
  {
    "<C-i>",
    function()
      vim.cmd "normal! \x01"
    end,
    desc = "Increment number under cursor",
  },
}
