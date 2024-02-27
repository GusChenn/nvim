local vim_opts = require("core.utils.utils").vim_opts

vim.g.mapleader = " " -- the leader key is the spacebar

vim.opt.shortmess:append("sIW")

vim_opts({
	opt = {
		autoindent = true,
		smartindent = true,
		hlsearch = true,
		showmode = false,
		number = true,
		signcolumn = "yes:1",
		numberwidth = 6,
		guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
		cursorline = true,
		expandtab = true,
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		updatetime = 100,
		linebreak = true,
		showbreak = ">>",
		textwidth = 100,
		breakindent = true,
		smartcase = true,
		ignorecase = true,
		scrolloff = 999,
		undofile = true,
		timeoutlen = 200,
		cursorlineopt = "number",
		inccommand = "split",
    conceallevel = 2,
	},
})
