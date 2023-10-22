local helpers = require("user.helpers")
local live_server = helpers.SafeRequire("live-server")

if not live_server then
	return
end

live_server.setup()
