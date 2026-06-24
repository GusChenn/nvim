-- HELPER FUNCTIONS --
local cmd = function(cmd)
    return string.format("<CMD> %s <CR>", cmd)
end

local map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    if type(rhs) == "string" then
        rhs = cmd(rhs)
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end
----------------------

-- MAPPED FUNCTIONS --
local function set_search_register()
    vim.opt.hlsearch = true
    local word = vim.fn.expand "<cword>"
    vim.fn.setreg("/", "\\<" .. word .. "\\>")
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
----------------------

vim.keymap.set("i", "jk", "<ESC>", { desc = "Quit insert mode with jk" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "Quit insert mode with kj" })

map("n", "<leader>Q", "wqa!", { desc = "Quit nvim" })
map("n", "<leader>s", set_search_register, { desc = "Highligh all instances of the word under the cursor" })
map("n", "<leader>wh", "split", { desc = "Split window horizontally" })
map("n", "<leader>wv", "vsplit", { desc = "Split window vertically" })
map("n", "<A-q>", "noautocmd w", { desc = "Save file without autocmds" })
map("n", "<leader>w", "w", { desc = "Save file with autocmds" })
map("n", "<leader>l", "noh", { desc = "Clear highlights" })
map("n", "cpp", copy_path, { desc = "Copies the current file path to the clipboard" })
map("n", "cpa", copy_absolute_path, { desc = "Copies the current file absolute path to the clipboard" })
map("n", "spp", show_path, { desc = "Shows the current file path" })
map("n", "<leader>L", "tabnext", { desc = "Next tab" })
map("n", "<leader>H", "tabprevious", { desc = "Previous tab" })
map("n", "<leader>T", "tabnew", { desc = "New tab" })
map("n", "<leader><tab>", "za", { desc = "Toggle fold" })
map("n", "<C-m>",
    function()
        vim.cmd "normal! \x01"
    end,
    { desc = "Increment number under cursor" }
)
map("v", "Y", '"+y', { desc = "Copy to system clipboard" })
