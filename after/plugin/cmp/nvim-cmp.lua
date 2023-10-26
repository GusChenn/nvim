local status, cmp = pcall(require, "cmp")
if not status then
	print("Somthing went wrong with cmp")
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	print("Somthing went wrong with lspkind")
	return
end

local cmp_vscode_kinds = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local border = {
	{ "┏", "FloatBorder" },
	{ "━", "FloatBorder" },
	{ "┓", "FloatBorder" },
	{ "┃", "FloatBorder" },
	{ "┛", "FloatBorder" },
	{ "━", "FloatBorder" },
	{ "┗", "FloatBorder" },
	{ "┃", "FloatBorder" },
}

local opts = {
	mode = "symbol_text",
	maxwidth = 30,
	ellipsis_char = "...",
	symbol_map = cmp_vscode_kinds,
}

cmp.setup({
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format(opts)(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			winhighlight = "Normal:CmpWindowBg,FloatBorder:CmpWindowBg,Search:None",
			col_offset = -3,
			side_padding = 0,
			scrollbar = false,
			max_height = 25,
			border = border,
		},
		documentation = {
			winhighlight = "Normal:CmpWindowBg,FloatBorder:CmpWindowBg,Search:None",
			side_padding = 1,
			border = border,
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}),
	{
		{ name = "buffer" },
	},
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
})





dskalfjdsa

-- Autocmd to make cmp not complete telescope prompt
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("REMOVE_TELESCOPE_PROMPT_CMP", {}),
	pattern = "TelescopePrompt",
	callback = function()
		cmp.setup({
			completion = {
				autocomplete = false,
			},
		})
	end,
})
