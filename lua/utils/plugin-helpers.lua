local plugin_helpers = {}

plugin_helpers.opts = function(desc)
	return { desc = desc, noremap = true, silent = true, nowait = true }
end

return plugin_helpers
