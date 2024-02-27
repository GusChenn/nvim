if vim.g.neovide then
  require("core.neovide-options")
elseif vim.g.vscode then
  require("core.vscode-config")
else
  require("core_init")
end
