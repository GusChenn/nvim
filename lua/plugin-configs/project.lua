require("cd-project").setup({
	-- this json file is acting like a database to update and read the projects in real time.
	-- So because it's just a json file, you can edit directly to add more paths you want manually
	projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/cd-project.nvim.json"),
	-- this controls the behaviour of `CdProjectAdd` command about how to get the project directory
	project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
	-- hooks = {
	-- 	{
	-- 		callback = function(dir) -- do whatever you like after `cd` to your project
	-- 			vim.notify("switched to dir: " .. dir)
	-- 		end,
	-- 	},
	-- 	{
	-- 		callback = function(dir)
	-- 			vim.notify("switched to dir: " .. dir)
	-- 		end, -- required, action when trigger the hook
	-- 		name = "cd hint", -- optional
	-- 		order = 1, -- optional, the execution order if there're multiple hooks to be trigger at one point
	-- 		pattern = "cd-project.nvim", -- optional, trigger hook if contains pattern, optional
	-- 		trigger_point = "DISABLE", -- optional, enum of trigger_points, default to `AFTER_CD`
	-- 		match_rule = function(dir) -- optional, a function return bool. if have this fields, then pattern will be ignored
	-- 			return true
	-- 		end,
	-- 	},
	-- },
})
