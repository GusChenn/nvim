local map = require("core.utils.utils").map

local M = {}

function M.vscode_map(m, k, vscode_cmd, vscode_args)
  if vscode_args then
    map(m, k, "<CMD>lua require('vscode-neovim').call('".. vscode_cmd .. "', " .. vscode_args .. ")<CR>")
  else
    map(m, k, "<CMD>lua require('vscode-neovim').call('".. vscode_cmd .. "')<CR>")
  end
end

function M.vscode_sequencial_map(m, k, vscode_cmds, vscode_args)
  local cmd = ""

  if vscode_args then
    for i = 1, #vscode_cmds, 1 do
      local vscode_cmd = vscode_cmds[i]
      local vscode_arg = vscode_args[i] or false

      if vscode_arg then
        cmd = cmd .. "<CMD>lua require('vscode-neovim').call('".. vscode_cmd .. "', " .. vscode_args .. ")<CR>"
      else
        cmd = cmd .. "<CMD>lua require('vscode-neovim').call('".. vscode_cmd .. "')<CR>"
      end
    end
  else
    for _,vscode_cmd in ipairs(vscode_cmds) do
      cmd = cmd .. "<CMD>lua require('vscode-neovim').call('".. vscode_cmd .. "')<CR>"
    end
  end

  map(m, k, cmd)
end

return M
