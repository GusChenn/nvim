local helpers = require("user.helpers")
local diaglist = helpers.SafeRequire("diaglist")

if not diaglist then
	return
end

diaglist.init({
	-- optional settings
	-- below are defaults
	debug = false,

	-- increase for noisy servers
	debounce_ms = 150,
})
