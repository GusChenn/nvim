local helpers = require("user.helpers")
local neoscroll = helpers.SafeRequire("neoscroll")

if not neoscroll then
	return
end

neoscroll.setup({
	easing_function = "sine",
})
