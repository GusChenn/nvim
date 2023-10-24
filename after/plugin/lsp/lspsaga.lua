local status, lspsaga = pcall(require, "lspsaga")
if not status then
	print("Somthing went wrong with lspsaga")
	return
end

lspsaga.setup({
	diagnostic = {
		keys = {
			quit = { "q", "<ESC>" },
		},
	},
	ui = {
		enable = false,
		sign = false,
		code_action = "☰",
		kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
	},
})
