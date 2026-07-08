-- The built-in foldcolumn always prints the fold level number when folds nest
-- deeper than the column is wide, and there is no option to turn that off.
-- So we disable it and draw our own 1-cell column via 'statuscolumn':
-- an arrow on lines where a fold starts, a blank space everywhere else.
vim.opt.foldcolumn = "0"

function _G.fold_arrows()
	-- wrapped (virtual) lines get a blank so the arrow shows only once per real line
	if vim.v.virtnum ~= 0 then
		return " "
	end
	local lnum = vim.v.lnum
	-- closed fold starting here
	if vim.fn.foldclosed(lnum) == lnum then
		return "▶"
	end
	-- open fold starting here (fold level went up compared to the line above)
	if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
		return "▼"
	end
	return " "
end

-- fold arrow, then signs, then line numbers (only when 'number' is on,
-- so the <leader>n toggle keeps working)
vim.opt.statuscolumn = "%{v:lua.fold_arrows()}%s%{%(&nu || &rnu) ? '%=%l ' : ''%}"
