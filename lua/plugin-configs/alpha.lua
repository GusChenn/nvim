local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	" ██████╗██╗   ██╗██████╗ ███████╗██████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
	"██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗████╗  ██║██║   ██║██║████╗ ████║",
	"██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝██╔██╗ ██║██║   ██║██║██╔████╔██║",
	"██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
	"╚██████╗   ██║   ██████╔╝███████╗██║  ██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
	" ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}
dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":lua require('core.utils.utils').create_new_file()<CR>"),
	dashboard.button("f", "  > Find file in git repo", ":Telescope git_files <CR>"),
	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
}
local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

require("alpha").setup(dashboard.opts)
