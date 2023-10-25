-- Automatically install and set up packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- Automatically run :PackerCompile whenever useins.lua is updated
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("PACKER_COMPILE", {}),
	pattern = vim.fn.expand("$HOME") .. "/.config/nvim/lua/user/plugins.lua",
	callback = function()
		vim.cmd.source()
		vim.cmd.PackerInstall()
		vim.cmd.PackerCompile()
	end,
})

-- Boilerplate ------------------
local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

local packer_bootstrap = ensure_packer()

-- Actual config ------------------

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	-- use("Mofiqul/dracula.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("tpope/vim-commentary")
	use("norcalli/nvim-colorizer.lua")
	use("windwp/nvim-autopairs")
	use("nvim-tree/nvim-web-devicons")
	use("windwp/nvim-ts-autotag")
	use("onsails/lspkind.nvim")
	use("mg979/vim-visual-multi")
	use("dimfred/resize-mode.nvim")
	use("sindrets/diffview.nvim")
	use("folke/zen-mode.nvim")
	use("folke/twilight.nvim")
	use("skywind3000/asyncrun.vim")
	use("ThePrimeagen/harpoon")
	use("NvChad/nvterm")

	-- For cmp stuff
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip")
	use("RRethy/nvim-treesitter-endwise")
	-----------------

	-- LSP stuff
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use({
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})
	use({
		"folke/trouble.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	-----------------

	-- Git stuff
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")
	use("f-person/git-blame.nvim")
	-----------------

	-- Linting and formatting
	use("jose-elias-alvarez/null-ls.nvim")
	use("MunifTanjim/prettier.nvim")
	--

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"sudormrfbin/cheatsheet.nvim",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({
		"L3MON4D3/LuaSnip",
		tag = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		run = "make install_jsregexp",
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "*",
		requires = "nvim-tree/nvim-web-devicons",
	})
	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
	})
	use({
		"barrett-ruth/live-server.nvim",
		run = "npm i -g live-server",
	})
	if packer_bootstrap then
		require("packer").sync()
	end
end)
