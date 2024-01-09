local enabled = require("core.utils.utils").enabled

require("lazy").setup({
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			require("plugin-configs.alpha")
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		config = function()
			require("plugin-configs.gitsigns")
		end,
	},
	{
		"phaazon/hop.nvim",
		event = "VimEnter",
		branch = "v2",
		config = function()
			require("plugin-configs.hop")
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VimEnter",
		branch = "v3.x",
		config = function()
			require("plugin-configs.lsp")
		end,
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
			},
			{ "williamboman/mason-lspconfig.nvim" },
		},
	},
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.neodev")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.neo-tree")
		end,
		branch = "v3.x",
		dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugin-configs.null-ls")
		end,
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullLsInstall", "NullLsUninstall" },
				config = function()
					require("plugin-configs.mason-null-ls")
				end,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugin-configs.autopairs")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugin-configs.cmp")
		end,
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{ "NvChad/nvim-colorizer.lua", event = "VimEnter" },
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.dap")
		end,
		dependencies = {
			{
				"jay-babu/mason-nvim-dap.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				config = function()
					require("plugin-configs.mason-nvim-dap")
				end,
			},
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("dapui").setup()
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
		},
	},
	{
		"kylechui/nvim-surround",
		cmd = "VimEnter",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("plugin-configs.treesitter")
		end,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup()
				end,
			},
			{ "windwp/nvim-ts-autotag" },
			{ "HiPhish/rainbow-delimiters.nvim" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
	},
	{
		"navarasu/onedark.nvim",
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build \
         build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			require("plugin-configs.telescope")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			_G.term = require("plugin-configs.toggleterm")
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},
	{
		"windwp/windline.nvim",
		event = "VeryLazy",
		config = function()
			require("wlsample.evil_line")
		end,
	},
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({ enabled = false })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugin-configs.harpoon")
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("plugin-configs.diffview")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-orgmode/orgmode",
		config = function()
			require("plugin-configs.orgmode")
		end,
	},
	{
		"dimfred/resize-mode.nvim",
		config = function()
			require("plugin-configs.resize-mode")
		end,
	},
	{
		"NvChad/nvterm",
		config = function()
			require("plugin-configs.nvterm")
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
	},
	{
		"tpope/vim-surround",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"Shatur/neovim-session-manager",
		config = function()
			require("plugin-configs.session-manager")
		end,
	},
	{ "savq/melange-nvim" },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}, {
	performance = {
		rtp = {
			disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
		},
	},
})
