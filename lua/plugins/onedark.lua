vim.pack.add({
	'https://github.com/navarasu/onedark.nvim',
})

require("onedark").setup {
  style = "darker",

  code_style = {
    comments = "italic",
    keywords = "italic",
    functions = "bold",
    strings = "none",
    variables = "bold",
  },

  transparent = true,
}

require('onedark').load()
