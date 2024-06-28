local loaders = {}

loaders.load_options = function()
	require("options")
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

loaders.load_custom_highlights = function()
	local highlights = require("options.custom-highlights").highlights
	local set_hl = vim.api.nvim_set_hl

	for group, opts in ipairs(highlights) do
		set_hl(0, group, opts)
	end
end

loaders.load_mini_modules = function(module_configs)
	local concat_plugin_root_name = function(module)
		return "mini." .. module
	end

	for _, module_config in ipairs(module_configs) do
		local full_module_name = concat_plugin_root_name(module_config.module)

		local ok, module = pcall(require, full_module_name)

		if ok and module then
			module.setup(module_config.config or {})
		else
			print("CUSTOM ERROR: Mini module " .. module_config.module .. " did not load properly")
		end
	end
end

return loaders
