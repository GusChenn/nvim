local helpers = require("core.vscode-config.helpers")

local map = require("core.utils.utils").map
local vscode_map = helpers.vscode_map
local vscode_sequencial_map = helpers.vscode_sequencial_map

-- Void
map("n", "Q", "<nop>")
map("n", "s", "<nop>")
map("n", "e", "<nop>")

-- Search and replace on file
map("n", "<leader>sr", "*<CMD>noh<CR>:%s//")

-- Yanking mappings
map("v", "Y", '"+y')

-- Closing editors
vscode_map("n", "<leader>q", "workbench.action.closeActiveEditor")

-- File explorer
vscode_map("n", "<leader>e", "workbench.action.toggleSidebarVisibility")
vscode_map("n", "<leader>E", "workbench.files.action.focusFilesExplorer")

-- Movement
vscode_map("", "<A-h>", "workbench.action.navigateLeft")
vscode_map("", "<A-j>", "workbench.action.navigateDown")
vscode_map("", "<A-k>", "workbench.action.navigateUp")
vscode_map("", "<A-l>", "workbench.action.navigateRight")
map("n", "q", "<ESC>")
map("n", "t", "%")
map("n", "<leader>s", "*")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("x", "p", '"_dP')

-- Harpoon-like navigation
vscode_map("n", "<leader>p", "workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup")
vscode_map("n", "<leader>h", "workbench.action.previousEditor")
vscode_map("n", "<leader>l", "workbench.action.nextEditor")

-- Splits
vscode_map("n", "<leader>wv", "workbench.action.splitEditor")
vscode_map("n", "<leader>wh", "workbench.action.splitEditorDown")

-- Move lines and blocks
map("x", "<A-j>", ":m '>+1<CR>gv=gv")
map("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- Search
vscode_map("n", "cm", "workbench.action.showCommands")
vscode_map("v", "fg", "workbench.action.findInFiles", "{ args = { query = vim.fn.expand('<cword>') } }")
vscode_map("n", "fg", "workbench.action.findInFiles")
vscode_map("n", "ff", "workbench.action.quickOpen")
vscode_sequencial_map("n", "cs", {"search.action.clearSearchResults", "workbench.action.closeSidebar", "workbench.action.closeActiveEditor"})

-- Quick fix (code actions)
vscode_map("n", "ca", "editor.action.quickFix")
vscode_map("n", "gl", "editor.action.marker.nextInFiles")

-- Terminal
vscode_map("n", "<A-t>", "workbench.action.focusActiveEditorGroup")

-- Source control (git)
vscode_map("n", "gs", "workbench.scm.focus")
vscode_map("n", "gb", "gitlens.toggleLineBlame")
