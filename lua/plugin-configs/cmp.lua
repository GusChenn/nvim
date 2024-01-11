local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
	enabled = function()
		-- disables in comments
		local context = require("cmp.config.context")
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		elseif vim.bo.buftype == "prompt" then
			return false
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	preselect = "none",
	completion = {
		keyword_length = 1,
		completeopt = "menu,menuone,noinsert,noselect",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = require("lspkind").cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
			mode = "symbol_text",
			symbol_map = { Copilot = "" },
		}),
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-c>"] = cmp.mapping.abort(),
		["<C-Space>"] = { i = cmp.mapping.complete() },
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
	},
	sources = {
		-- { name = "copilot" },
		{ name = "nvim_lsp" },
		-- { name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "luasnip" },
		-- { name = "path", option = { trailing_slash = true } },
		{ name = "orgmode" },
	},
})
