local loaders = {}

loaders.load_options = function()
  require "options"
end

loaders.bootstrap_lazy_nvim = function()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

loaders.load_lazy = function()
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

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
          -- "matchit",
          -- "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    dev = {
      path = "~/Repos/projects/lua/",
      patterns = { "postit-nvim" },
      fallback = false,
    },
  }
end

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
  -- For catppuccin
  -- require "config.themes.catppuccin"
  -- vim.cmd.colorscheme "catppuccin"

  -- For everfores
  -- require "config.themes.everfores"
  -- vim.cmd.colorscheme "everforest"

  -- For oldworld
  -- require "config.themes.oldworld"
  -- vim.cmd.colorscheme "oldworld"

  -- For eva01
  -- vim.cmd.colorscheme "eva01-LCL"

  -- For eva01-custom
  -- require("config.themes.eva01-custom").setup()

  -- For zenbones
  -- require "config.themes.zenbones"
  -- vim.cmd.colorscheme "forestbones"

  -- For github theme
  -- require "config.themes.github"
  -- vim.cmd.colorscheme "github_light_high_contrast"

  -- For pfalseoimadres
  -- require "config.themes.poimadres"
  -- vim.cmd.colorscheme "poimadres"

  -- For noirbuddy
  -- require "config.themes.noirbuddy"

  -- For nightfox
  if vim.o.background == "light" then
    -- require "config.themes.nightfox"
    -- vim.cmd.colorscheme "dawnfox"

    require "config.themes.gruvbox"
    vim.cmd.colorscheme "gruvbox-material"
  else
    -- require "config.themes.catppuccin"
    -- vim.cmd.colorscheme "catppuccin"

    -- require "config.themes.everfores"
    -- vim.cmd.colorscheme "everforest"

    -- For gruvbox
    require "config.themes.gruvbox"
    vim.cmd.colorscheme "gruvbox-material"

    -- For rose-pine
    -- require "config.themes.rose-pine"
    -- vim.cmd.colorscheme "rose-pine"
  end
end

loaders.load_custom_highlights = function()
  local custom_hls = require("options.custom-highlights").custom_highlights()

  for group, opts in pairs(custom_hls) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return loaders
