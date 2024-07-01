local loaders = {}

loaders.load_options = function()
  require "options"
end

loaders.bootstrap_lazy_nvim = function()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  end
  vim.opt.rtp:prepend(lazypath)
end

loaders.load_lazy = function()
  require("lazy").setup {
    defaults = {
      lazy = true,
    },
    spec = {
      { import = "plugins" },
    },
    install = {
      colorscheme = { "catppuccin" },
    },
    -- automatically check for plugin updates
    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      notify = false,
    },
    ui = {
      border = "single",
    },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }
end

-- loaders.load_custom_highlights = function()
--   local highlights = require("options.custom-highlights").custom_personal_highlights()
--   local set_hl = vim.api.nvim_set_hl
--
--   for group, opts in ipairs(highlights) do
--     set_hl(0, group, opts)
--   end
-- end

loaders.load_mini_modules = function(module_configs)
  local concat_plugin_root_name = function(module)
    return "mini." .. module
  end

  for _, module_config in ipairs(module_configs) do
    local full_module_name = concat_plugin_root_name(module_config.module)

    local ok, module = pcall(require, full_module_name)

    if ok and module then
      module.setup(module_config.config or {})
    else
      print("CUSTOM ERROR: Mini module " .. module_config.module .. " did not load properly")
    end
  end
end

loaders.load_mappings = function()
  -- Load mappings lazily

  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      require "config.mappings"
    end,
  })
end

loaders.load_colorscheme = function()
  require("catppuccin").setup {
    -- transparent_background = vim
    flavour = "mocha",
    color_overrides = {
      latte = {
        rosewater = "#cc7983",
        flamingo = "#bb5d60",
        pink = "#d54597",
        mauve = "#a65fd5",
        red = "#b7242f",
        maroon = "#db3e68",
        peach = "#e46f2a",
        yellow = "#bc8705",
        green = "#1a8e32",
        teal = "#00a390",
        sky = "#089ec0",
        sapphire = "#0ea0a0",
        blue = "#017bca",
        lavender = "#8584f7",
        text = "#444444",
        subtext1 = "#555555",
        subtext0 = "#666666",
        overlay2 = "#777777",
        overlay1 = "#888888",
        overlay0 = "#999999",
        surface2 = "#aaaaaa",
        surface1 = "#bbbbbb",
        surface0 = "#cccccc",
        base = "#ffffff",
        mantle = "#eeeeee",
        crust = "#dddddd",
      },
    },
    term_colors = true,
    integrations = {
      cmp = true,
      flash = true,
      gitsigns = true,
      mini = {
        enabled = true,
      },
      mason = true,
      markdown = true,
      neogit = true,
      nvimtree = true,
      ufo = true,
      telescope = { enabled = true, style = "nvchad" },
      treesitter = true,
      lsp_saga = true,
    },
  }
  vim.cmd.colorscheme "catppuccin"
end

return loaders
