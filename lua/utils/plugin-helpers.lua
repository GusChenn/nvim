local plugin_helpers = {}

plugin_helpers.opts = function(desc)
  return { desc = desc, noremap = true, silent = true, nowait = true }
end

plugin_helpers.cmd = function(cmd)
  return string.format("<CMD> %s <CR>", cmd)
end

return plugin_helpers
