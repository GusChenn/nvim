local helpers = require("user.helpers")
local auto_session = helpers.SafeRequire("auto-session")

if not auto_session then
	return
end

auto_session.setup({})
