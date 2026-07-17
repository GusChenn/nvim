vim.pack.add({
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/antoinemadec/FixCursorHold.nvim",
  "https://github.com/zidhuss/neotest-minitest",
  "https://github.com/nvim-neotest/neotest",
})

local minitest = require("neotest-minitest")({
  test_cmd = function()
    -- `-e CONSOLE_LEVEL=fatal`: under Falcon, console-adapter-rails owns
    -- Rails.logger (the `console` gem), which streams info-level JSON to STDOUT
    -- during the run and interleaves into minitest's verbose
    -- `Name = <time> s = .` line -> neotest-minitest's result parser can't match
    -- the status, so every passing test shows as failed. The console gem's level
    -- is set via CONSOLE_LEVEL (NOT RAILS_LOG_LEVEL, which it ignores); fatal
    -- keeps STDOUT clean so statuses parse. Only affects this neotest-spawned
    -- process and changes log verbosity only, never RAILS_ENV -> can't touch the
    -- local db.
    return {
      "docker",
      "compose",
      "exec",
      "-i",
      "-e",
      "CONSOLE_LEVEL=fatal",
      "service-app",
      "bin/rails",
      "test",
    }
  end,

  transform_spec_path = function(path)
    local prefix = require('neotest-minitest').root(path)
    return string.sub(path, string.len(prefix) + 2, -1)
  end,

  results_path = "tmp/minitest.output"
})

-- The adapter builds an anchored name filter `/^Class|Class$/` using only the
-- last constant of the class name (init.lua:122). For module-namespaced test
-- classes (e.g. `Files::IngestTest`) the real runnable is `Files::IngestTest#…`,
-- which neither `^Class` nor `Class$` matches -> "Nothing ran for filter".
-- Strip ONLY the leading `^` so the first alternative becomes an unanchored
-- substring (fixes whole-class runs) while the trailing `…$` suffix match on the
-- second alternative is left intact (keeps single-test runs working).
local build_spec = minitest.build_spec
minitest.build_spec = function(args)
  local spec = build_spec(args)
  if spec and spec.command then
    for i, v in ipairs(spec.command) do
      if v == "--name" and spec.command[i + 1] then
        spec.command[i + 1] = spec.command[i + 1]:gsub("^/%^", "/")
      end
    end
  end
  return spec
end

require("neotest").setup({
  adapters = { minitest },
})

vim.keymap.set("n", "<leader>tn", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run all tests in file" })
vim.keymap.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
