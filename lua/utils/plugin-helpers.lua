local plugin_helpers = {}

plugin_helpers.opts = function(desc)
  return { desc = desc, noremap = true, silent = true, nowait = true }
end

plugin_helpers.cmd = function(cmd)
  return string.format("<CMD> %s <CR>", cmd)
end

local function match_path(partial_path)
  local base_dir = vim.fn.getcwd() -- Get the current working directory

  -- Adjust partial path to remove leading slash if necessary
  partial_path = partial_path:gsub("^/", "")

  -- Shell command to list all directories from the base directory
  local shell_cmd = string.format("find %q -type d", base_dir)

  -- Open a process to execute the command and read its output
  local handle = io.popen(shell_cmd)
  local result = nil

  if not handle then return end

  -- Iterate over each line of the command output
  for line in handle:lines() do
    -- Convert the full path to a relative path
    local relative_path = line:sub(#base_dir + 2) -- Strip the base directory and leading "/"

    -- Check if the relative path ends with the partial path
    if relative_path:sub(- #partial_path) == partial_path then
      result = relative_path
      break -- Stop at the first match
    end
  end

  handle:close()

  return result
end

plugin_helpers.pick_folder_files = function(folder_partial_path)
  local target_folder_relative_path = match_path(folder_partial_path) or ""

  local files = vim.fn.readdir('./' .. target_folder_relative_path)

  local picked_file = MiniPick.start({ source = { items = files } })

  local file_full_path = table.concat({ target_folder_relative_path, picked_file }, '/')

  vim.cmd.edit(file_full_path)
end

return plugin_helpers
