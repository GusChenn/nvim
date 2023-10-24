local helpers = require("user.helpers")
local gitblame = helpers.SafeRequire("gitblame")

if not gitblame then
	return
end

gitblame.setup({
	enabled = false,
})
