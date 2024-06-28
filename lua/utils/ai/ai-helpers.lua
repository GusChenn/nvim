local M = {}

M.commit_with_ai = function()
  local copilot_chat = require "CopilotChat"
  local select = require "CopilotChat.select"
  local prompts = require "utils.ai.prompts"

  local commit_response = function(response)
    local a = require "plenary.async"

    local async_commit = function(neogit_commit_popup)
      require("neogit.popups.commit.actions").commit(neogit_commit_popup)
    end

    local format_commit_message = function(commit_message)
      local lines = {}
      local trimmed_message = commit_message:gsub("^```gitcommit\n", ""):gsub("\n```", "")
      for line in trimmed_message:gmatch "[^\r\n]+" do
        table.insert(lines, line)
      end
      return lines
    end
    vim.cmd "CopilotChatClose"

    local neogit_commit_popup = require("neogit.popups.commit").create {}

    a.run(function()
      async_commit(neogit_commit_popup)
    end)
    --
    vim.wait(2000)
    --
    vim.api.nvim_put(format_commit_message(response), "l", true, false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("kJ", true, true, true), "n", false)
  end

  local has_diffs = os.execute "git diff --exit-code --cached --quiet"
  if has_diffs ~= 0 then
    copilot_chat.ask(prompts.commit, {
      selection = function(source)
        return select.gitdiff(source, true)
      end,
      callback = commit_response,
      kind = "user",
    })
  else
    print "No Git diffs"
  end
end

M.toggle_copilot_chat = function()
  if not CopilotChatLoaded then
    vim.cmd("CopilotChatLoad " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
    CopilotChatLoaded = true
  else
    vim.cmd "CopilotChatToggle"
  end
end

return M
