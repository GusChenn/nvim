local status, luasnip_loader = pcall(require, "luasnip.loaders.from_vscode")
if not status then
	print("Somthing went wrong with luasnip loader")
	return
end

luasnip_loader.lazy_load()
