local helpers = require("user.helpers")
local zen_mode = helpers.SafeRequire("zen-mode")

if not zen_mode then
	return
end

zen_mode.setup()
