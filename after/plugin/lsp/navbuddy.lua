local helpers = require("user.helpers")
local navbuddy = helpers.SafeRequire("nvim-navbuddy")

if not navbuddy then
	return
end

navbuddy.setup()
