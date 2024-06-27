local loaders = require("utils.loaders")

-- Bootstrap lazy.nvim
loaders.bootstrap_lazy_nvim()

-- Setup options
loaders.load_options()

-- Setup lazy.nvim
loaders.load_lazy()
