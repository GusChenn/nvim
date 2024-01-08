require("orgmode").setup_ts_grammar()

require("orgmode").setup({
	org_agenda_files = { "~/Documents/Notes/org/*", "~/Documents/Notes/my-orgs/**/*" },
	org_default_notes_file = "~/Documents/Notes/org/refile.org",
	win_split_mode = function(name)
		local bufnr = vim.api.nvim_create_buf(false, true)
		--- Setting buffer name is required
		vim.api.nvim_buf_set_name(bufnr, name)

		local fill = 0.8
		local width = math.floor((vim.o.columns * fill))
		local height = math.floor((vim.o.lines * fill))
		local row = math.floor((((vim.o.lines - height) / 2) - 1))
		local col = math.floor(((vim.o.columns - width) / 2))

		vim.api.nvim_open_win(bufnr, true, {
			relative = "editor",
			width = width,
			height = height,
			row = row,
			col = col,
			style = "minimal",
			border = "rounded",
		})
	end,
	org_hide_leading_stars = true,
})
