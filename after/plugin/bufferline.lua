local status, bufferline = pcall(require, 'bufferline')
if (not status) then
  print("Somthing went wrong with bufferline")
  return
end

bufferline.setup {
  options = {
    style_preset = {
      bufferline.style_preset.minimal,
      bufferline.style_preset.no_italic,
      bufferline.style_preset.no_bold,
    },
    numbers = function(opts)
      return string.format('%s', opts.lower(opts.ordinal))
    end,
    themable = true,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or ""
      return "" .. icon .. count
    end,
    groups = {
      items = {
        require('bufferline.groups').builtin.pinned:with({ icon = "" })
      }
    },
  },
}

