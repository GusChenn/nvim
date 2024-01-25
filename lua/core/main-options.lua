local vim_opts = require("core.utils.utils").vim_opts

vim.opt.shortmess:append("sIW")

vim_opts({
	opt = {
		autoindent = true,
		smartindent = true,
		hlsearch = true,
		shell = "zsh",
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
		-- breakindentopt = "shift:2,min:40,sbr",
		smartcase = true,
		ignorecase = true,
		foldmethod = "expr",
		foldexpr = "nvim_treesitter#foldexpr()",
		foldlevel = 9999,
		foldlevelstart = 9999,
		-- foldopen = "jump,block,hor,mark,percent,quickfix,search,tag,undo",
		foldenable = false,
		scrolloff = 999,
		-- autowrite = true,
		-- confirm = true,
		-- autochdir = true,
		-- termguicolors = true,
		undofile = true,
		-- sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
		-- hidden = true,
		-- laststatus = 3,
		timeoutlen = 200,
		cursorlineopt = "number",
		inccommand = "split",
	},
})

-- Tmux gloab declaration
vim.g.tmux_navigator_no_mappings = 1
