local harpoon = require("harpoon")

local format_list_item = function(list_item)
	-- return only the part after the last / character on the path
	if not list_item.value:match("^.+/(.+)$") then
		return "-- delete me or else i will explode --"
	else
		return "➜ " .. list_item.value:match("^.+/(.+)$")
	end
end

harpoon.setup({
	settings = {
		save_on_toggle = true,
	},
	default = {
		display = format_list_item,
	},
})
