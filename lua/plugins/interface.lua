return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			view = {
				width = 60,
				side = "right",
			},
			filters = {
				enable = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local opts = require("utils.plugin-helpers").opts
				local map = vim.keymap.set

				-- Load default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- Load custom mappings
				map("n", "h", api.node.navigate.parent_close, opts("Up"))
				map("n", "l", api.node.open.edit, opts("Up"))
			end,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		opts = {
			endwise = {
				enable = true,
			},
			matchup = {
				enable = true,
				disable_virtual_text = true,
			},
			ensure_installed = {
				require("config.relevant").treesitter.ensure_installed,
			},
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",
		opts = {
			---@usage 'background'|'foreground'|'virtual'
			render = "virtual",
			virtual_symbol = "◉",

			enable_named_colors = true,
			enable_tailwind = true,
		},
	},
	{
		"folke/zen-mode.nvim",
	},
	{
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		opts = {
			chunk = {
				enable = true,
				use_treesitter = true,
				chars = {
					horizontal_line = "─",
					left_top = "┌",
					vertical_line = "│",
					left_bottom = "└",
					right_arrow = "─",
				},
				style = {
					{
						-- TODO: Get color from theme
						fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("MatchParen")), "bg", "gui"),
					},
				},
				max_file_size = 80 * 1024,
			},
			indent = {
				enable = false,
			},
			line_num = {
				enable = false,
			},
			blank = {
				enable = false,
			},
		},
	},
	{
		"RRethy/vim-illuminate",
		event = { "UIEnter" },
		config = function()
			require("illuminate").configure({

				modes_denylist = {
					"i",
					"ic",
					"ix",
				},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
					"copilot-chat",
					"NvimTree",
				},
				providers = {
					"regex",
					"treesitter",
					"lsp",
				},
				min_count_to_highlight = 2,
			})
		end,
	},
	-- {
	-- 	"kevinhwang91/nvim-bqf",
	-- 	ft = "qf",
	-- 	opts = {
	-- 		preview = {
	-- 			border = "single",
	-- 			show_scroll_bar = false,
	-- 			winblend = 0,
	-- 			wrap = true,
	-- 		},
	-- 	},
	-- },
	{
		"kevinhwang91/nvim-ufo",
		event = "UIEnter",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		opts = {
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		},
	},

	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
		opts = {
			scope = "git_branch",
			style = "basename",
			win_opts = {
				border = "solid",
			},
		},
	},
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	cmd = { "Telescope" },
	-- 	-- event = "VeryLazy",
	-- 	opts = {
	-- 		pickers = {
	-- 			find_files = {
	-- 				theme = "ivy",
	-- 			},
	-- 			live_grep = {
	-- 				theme = "ivy",
	-- 			},
	-- 		},
	-- 		extensions = {
	-- 			fzf = {
	-- 				fuzzy = true, -- false will only do exact matching
	-- 				override_generic_sorter = true, -- override the generic sorter
	-- 				override_file_sorter = true, -- override the file sorter
	-- 				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
	-- 			},
	-- 			undo = {
	-- 				use_delta = true,
	-- 				use_custom_command = nil,
	-- 				side_by_side = true,
	-- 				diff_context_lines = 10,
	-- 				entry_format = "N∘ $ID, $STAT, $TIME",
	-- 				time_format = "",
	-- 				saved_only = false,
	-- 				mappings = {
	-- 					i = {
	-- 						["<cr>"] = require("telescope-undo.actions").yank_additions,
	-- 						["<C-y>"] = require("telescope-undo.actions").yank_deletions,
	-- 						["<C-r>"] = require("telescope-undo.actions").restore,
	-- 					},
	-- 					n = {
	-- 						["y"] = require("telescope-undo.actions").yank_additions,
	-- 						["Y"] = require("telescope-undo.actions").yank_deletions,
	-- 						["u"] = require("telescope-undo.actions").restore,
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	init = function()
	-- 		local telescope = require("telescope")
	-- 		telescope.load_extension("fzf")
	-- 		telescope.load_extension("undo")
	-- 	end,
	-- 	dependencies = {
	-- 		{
	-- 			"nvim-telescope/telescope-fzf-native.nvim",
	-- 			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	-- 		},
	-- 		"nvim-lua/plenary.nvim",
	-- 		"debugloop/telescope-undo.nvim",
	-- 	},
	-- 	{
	-- 		"RRethy/nvim-treesitter-endwise",
	-- 		event = "BufEnter",
	-- 		dependencies = {
	-- 			"nvim-treesitter",
	-- 		},
	-- 	},
	-- },
	-- TODO: setup Obsidian/ Neorg
	-- {
	-- 	"tpope/vim-surround",
	-- 	event = "VeryLazy",
	-- },
	{
		"github/copilot.vim",
		event = "VeryLazy",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = {
			"CopilotChatOpen",
			"CopilotChatToggle",
			"CopilotChatExplain",
			"CopilotChatTest",
			"CopilotChatCommitStaged",
			"CopilotChatLoad",
		},
		branch = "canary",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			context = "buffers",

			question_header = "󰙊 ", -- Header to use for user questions
			answer_header = " ", -- Header to use for AI answers
			error_header = " ", -- Header to use for errors
			separator = " ", -- Separator to use in chat

			show_help = false,
			show_folds = false,
			auto_follow_cursor = false,

			callback = function()
				-- Calls the CopilotChatSave <name> command passing <name> as the root directory name
				vim.cmd("CopilotChatSave " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
			end,

			mappings = {
				reset = {
					normal = "<leader><C-l>",
				},
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<S-Tab>",
				},
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "typescriptreact", "tsx", "html" },
		config = true,
	},
	-- {
	-- 	"nvim-neotest/neotest",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"nvim-neotest/nvim-nio",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"olimorris/neotest-rspec",
	-- 	},
	-- 	opts = {
	-- 		adapters = {
	-- 			require("neotest-rspec"),
	-- 		},
	-- 	},
	-- },
	{
		"andymass/vim-matchup",
		event = "UIEnter",
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		config = true,
	},
	-- {
	-- 	"dmmulroy/ts-error-translator.nvim",
	-- 	event = { "BufEnter *.ts", "BufEnter *.tsx", "BufEnter *.js", "BufEnter *.jsx" },
	-- 	config = true,
	-- },
	{
		"farmergreg/vim-lastplace",
		event = "UIEnter",
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {
			log_level = "error",
			-- auto_session_enable_last_session = true,
			-- auto_restore_enabled = true,
			auto_session_use_git_branch = true,

			pre_save_cmds = {
				"silent! NvimTreeClose",
				"silent! CopilotChatClose",
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = true,
					label = {
						style = "overlay",
					},
				},
				char = {
					enabled = false,
				},
			},
		},
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			local loaders = require("utils.loaders")

			local module_configs = {
				{ module = "ai" },
				{ module = "bufremove" },
				{ module = "pairs" },
				{ module = "splitjoin" },
				{ module = "surround" },
				{
					module = "pick",
					config = {
						window = {
							config = {
								border = "solid",
							},
							prompt_cursor = " ",
							prompt_prefix = "  ",
						},
					},
				},
				{ module = "extra" },
			}

			loaders.load_mini_modules(module_configs)
		end,
	},
}
