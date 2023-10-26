local helpers = require("user.helpers")
local ibl = helpers.SafeRequire("ibl")

if not ibl then
	return
end

ibl.setup()
