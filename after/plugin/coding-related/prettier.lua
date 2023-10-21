local helpers = require("user.helpers")
local prettier = helpers.SafeRequire("prettier")

if prettier then
	prettier.setup({
		bin = "prettierd",
		filetype = {
			"css",
			"graphql",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"less",
			"markdown",
			"scss",
			"typescript",
			"typescriptreact",
			"yaml",
		},
	})
end
