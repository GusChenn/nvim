local M = {}

M.highlights = {
	-- General --
	Comment = { italic = true },
	Statement = { italic = true },
	Define = { italic = true },
	Include = { italic = true },
	Function = { italic = true },
	Keyword = { italic = true },
	SpecialComment = { italic = true },
	CursorLine = { bg = "statusline_bg" },
	Delimiter = { italic = true },
	FloatBorder = { link = "NormalFloat" },

	-- Treesitter --
	TSVariable = { italic = true },
	TSKeyword = { italic = true },
	TSMethod = { italic = true },
	TSDefine = { italic = true },
	["@tag.attribute"] = { italic = true },
	["@variable.parameter"] = { italic = true },
	["@keyword"] = { italic = true },
	["@tag"] = { bold = true },
	["@function.call"] = { bold = true },
	["@comment"] = { italic = true },
	eliixirString = { italic = true },

	-- Illuminate --
	IlluminatedWordWrite = { link = "Pmenu" },
	IlluminatedWordText = { link = "Pmenu" },
	IlluminatedWordRead = { link = "Pmenu" },

	-- Mini module --
	MiniPickMatchCurrent = { link = "PmenuSel" },

	-- Flash --
	FlashLabel = { bg = "NvimLightGreen", bold = true, italic = true },
}

return M
