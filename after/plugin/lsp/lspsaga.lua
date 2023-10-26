local status, lspsaga = pcall(require, "lspsaga")
if not status then
	print("Somthing went wrong with lspsaga")
	return
end

lspsaga.setup({
	lightbulb = {
		enable = false,
	},
	diagnostic = {
		keys = {
			quit = { "q", "<ESC>" },
		},
	},
	ui = {
		kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
	},
	symbol_in_winbar = {
		separator = " ▶ ",
	},
})
