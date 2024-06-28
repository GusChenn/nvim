print("hahhaah")

local loaders = require("utils.loaders")

-- Bootstrap lazy.nvim
loaders.bootstrap_lazy_nvim()

-- Setup options
loaders.load_options()

-- Setup lazy.nvim
loaders.load_lazy()

-- Setup custom highlights
loaders.load_custom_highlights()
