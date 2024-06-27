local loaders = {}

loaders.load_options = function()
	require("config.options")
end

loaders.bootstrap_lazy_nvim = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	end
	vim.opt.rtp:prepend(lazypath)
end

loaders.load_lazy = function()
	require("lazy").setup({
		defaults = {
			lazy = true,
		},
		spec = {
			{ import = "plugins" },
		},
		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		install = { colorscheme = { "habamax" } },
		-- automatically check for plugin updates
		checker = { enabled = true },
	})
end

return loaders
