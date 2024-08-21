require("cyberdream").setup({
  -- Enable transparent background
  transparent = false,

  -- Enable italics comments
  italic_comments = true,

  -- Replace all fillchars with ' ' for the ultimate clean look
  hide_fillchars = true,

  -- Modern borderless telescope theme - also applies to fzf-lua
  borderless_telescope = true,

  -- Set terminal colors used in `:terminal`
  terminal_colors = true,

  -- Use caching to improve performance - WARNING: experimental feature - expect the unexpected!
  -- Early testing shows a 60-70% improvement in startup time. YMMV. Disables dynamic light/dark theme switching.
  cache = true, -- generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache

  theme = {
    variant = "light", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
    highlights = {},
  },

  -- Disable or enable colorscheme extensions
  extensions = {
    telescope = true,
    notify = true,
    mini = true,
    cmp = true,
    gitsigns = true,
    grapple = true,
    markdown = true,
    neogit = true,
    treesitter = true,
    trouble = true,
    whichkey = true,
  },
})
