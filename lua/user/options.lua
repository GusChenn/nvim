local opt = vim.opt
local g = vim.g
local o = vim.o
local wo = vim.wo

g.mapleader = " "
g.localleader = " "

opt.fillchars = {
    vert = " ",
    eob = " ",
    foldclose = "▶", -- For closed folds
    foldopen = "▼", -- For open folds
    fold = " ", -- For the rest of the fold column
}
