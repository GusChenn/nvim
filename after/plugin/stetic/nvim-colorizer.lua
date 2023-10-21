local status, colorizer = pcall(require, "colorizer")
if not status then
	print("Somthing went wrong with colorizer")
	return
end

colorizer.setup()
