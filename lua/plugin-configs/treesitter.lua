local exist, user_config = pcall(require, "user.user_config")
local sources = exist
		and type(user_config) == "table"
		and user_config.ensure_installed
		and user_config.ensure_installed.treesitter
	or {}

require("nvim-treesitter.configs").setup({
	ensure_installed = sources,
	highlight = {
		enable = true,
		disable = { "html", "org" },
	},
	incremental_selection = { enable = true },
	autotag = { enable = true },
	rainbow = { enable = true, disable = { "html" }, extended_mode = false },
	additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
	endwise = { enable = true },
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.slim = {
  install_info = {
    url = "https://github.com/kolen/tree-sitter-slim", -- local path or git repo
    files = {"src/scanner.cc"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "master", -- default branch in case of git repo if different from master
    generate_requires_npm = true, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  -- filetype = "slim", -- if filetype does not match the parser name
}

vim.treesitter.language.register('slim', 'slim')
