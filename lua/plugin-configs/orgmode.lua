require("orgmode").setup_ts_grammar()

require("orgmode").setup({
	org_agenda_files = { "~/Documents/Notes/org/*", "~/Documents/Notes/my-orgs/**/*" },
	org_default_notes_file = "~/Documents/Notes/org/refile.org",
})
