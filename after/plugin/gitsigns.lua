local status, gitsigns = pcall(require, "gitsigns")
if not status then
	print("Somthing went wrong with gitsigns")
	return
end

gitsigns.setup({})
