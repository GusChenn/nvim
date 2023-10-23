local helpers = {}

function helpers.SafeRequire(package_name)
	local status, package = pcall(require, package_name)
	if not status then
		print("Somthing went wrong with " .. package_name)
		return error("There was an error while trying to load a package")
	end
	return package
end

return helpers