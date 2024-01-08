local map = require("core.utils.utils").map

require("plugin-configs.lsp.lua")
require("plugin-configs.lsp.tsserver")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }

		map("n", "rg", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "global substitution" })
		map("n", "gd", "<CMD>lua buf.declaration()<CR>", opts)
		map("n", "gD", "<CMD>Telescope lsp_definitions<CR>", opts)
		map("n", "K", "<CMD>lua buf.hover()<CR>", opts)
		map("n", "gi", "<CMD>lua buf.implementation()<CR>", opts)
		map("n", "gr", "<CMD>Telescope lsp_references<CR>", opts)
		map("n", "sh", "<CMD>lua buf.signature_help()<CR>", opts)
		map("n", "<leader>rn", "<CMD>lua buf.rename()<CR>", opts)
		map("n", "gl", "<CMD>lua buf.code_action()<CR>", opts)
	end,
})
