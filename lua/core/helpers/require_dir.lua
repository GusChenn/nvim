local require_dir = function()
    local this_file = debug.getinfo(1, "S").source:sub(2)
    local dir = vim.fn.fnamemodify(this_file, ":h")

    for _, file in ipairs(vim.fn.glob(dir .. "/*.lua", false, true)) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        if name ~= "index" then
            local mod = file:match(".*/lua/(.+)%.lua$"):gsub("/", ".")
            require(mod)
        end
    end
end

return require_dir
