local usercmd = vim.api.nvim_create_user_command

usercmd("Reload", function()
  -- Clear all cached modules under lua/
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^core") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.fn.stdpath("config") .. "/init.lua")
  vim.notify("Config reloaded", vim.log.levels.INFO)
end, { desc = "Reload config" })
