local loaders = require "utils.loaders"

-- Bootstrap lazy.nvim
loaders.bootstrap_lazy_nvim()

-- Setup lazy.nvim alongside plugins
loaders.load_lazy()

-- Setup options
loaders.load_options()

-- Setup mappings
loaders.load_mappings()

-- Setup colorscheme
loaders.load_colorscheme()

-- Setup custom highlights
loaders.load_custom_highlights()
