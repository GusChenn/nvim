-- Befora anything, install all the LSP servers needed. 
-- In this case, we will need typescript-language-server, diagnostic-languageserver 

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)

  -- [[ Default ]]
  use "wbthomason/packer.nvim"                 -- Have packer manage itself
  use "nvim-lua/popup.nvim"                    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"                  -- Useful lua functions used ny lots of plugins

  -- [[ Theme ]]
  use "Mofiqul/dracula.nvim"                   -- Dracula theme

  -- [[ LSP ]]
  use "neovim/nvim-lspconfig"                  -- LSP config
  use "williamboman/nvim-lsp-installer"        -- LSP bootstrap
  use { 'tami5/lspsaga.nvim' }                 -- Beautifier

  -- [[ Completion ]]
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "saadparwaiz1/cmp_luasnip"

  -- [[ Snippets ]]
  use "L3MON4D3/LuaSnip"                        -- snippet engine
  use "rafamadriz/friendly-snippets"            -- bunch of snippets

  -- [[ Highlight ]]
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
  }

  -- [[ FZF and more ]]
  use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-media-files.nvim'

  -- [[ Auto pair ]]
  use "windwp/nvim-autopairs"

  -- [[ Comments ]]
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- [[ Tree view ]]
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"

  -- [[ Lua line ]]
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- [[ ToggleTerm ]]
  use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
    require("toggleterm").setup()
  end}

    -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
