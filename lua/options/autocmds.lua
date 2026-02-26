local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local highlight = require "utils.highlight"

-- This command is necessary so we dont change the current active tab after resizing
autocmd({ "VimResized" }, {
  desc = "Auto resize panes when resizing nvim window",
  pattern = "*",
  command = [[
    let _auto_resize_current_tab = tabpagenr()
    tabdo wincmd =
    execute 'tabnext' _auto_resize_current_tab
  ]],
})

-- not working
-- vim.api.nvim_create_autocmd("FileType", {
--   desc = "Change background color for codecompanion buffers",
--   pattern = "codecompanion",
--   callback = function()
--     -- Create a temporary highlight group with the new background color
--     vim.api.nvim_set_hl(0, "CodeCompanionTempBg", { bg = "#f0f0f0" })
--     -- Iterate over all open windows
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--       -- Get the buffer associated with the window
--       local buf = vim.api.nvim_win_get_buf(win)
--       -- Check if the buffer's filetype is 'codecompanion'
--       local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
--       if filetype == "codecompanion" then
--         -- Apply the winhighlight to the window
--         vim.print("triggering on win " .. win .. "with buffer " .. buf)
--         vim.api.nvim_set_option_value("winhighlight", "Normal:CodeCompanionTempBg", { win = win + 1 })
--         break
--       end
--     end
--   end,
-- })

autocmd({ "FileType" }, {
  desc = "Disable cmp in certain filetypes",
  pattern = "gitcommit,gitrebase,text,markdown,copilot-chat",
  command = "lua require('cmp').setup.buffer { enabled = false}",
  group = augroup("cmp_disable", { clear = true }),
})

autocmd({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  callback = highlight.on_yank,
  group = vim.api.nvim_create_augroup("highlight", {}),
})

autocmd({ "FileType" }, {
  desc = "Close quick fix list after selecting a element",
  pattern = "qf",
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

autocmd({ "FileType" }, {
  desc = "Close quick fix list with q",
  pattern = "qf",
  command = [[nnoremap <buffer> q <CMD>:cclose<CR>]],
})

autocmd({ "BufRead" }, {
  desc = "Treat slim files as ruby files",
  pattern = { "*.slim" },
  command = [[setfiletype ruby]],
})

autocmd("FileType", {
  desc = "Set formatprg to jq for json files",
  pattern = { "json" },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
  end,
})

autocmd("FileType", {
  desc = "Enable spell checking for markdown files",
  pattern = { "markdown" },
  command = "setlocal spell",
})

autocmd("LspProgress", {
  desc = "Displays spinner while LSP is processing",
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

local group = augroup("CodeCompanionHooks", {})

autocmd({ "User" }, {
  desc = "Handle CodeCompanion request events. Necessary so the codecompanion statusline spinner works",
  pattern = "CodeCompanionRequest*",
  group = group,
  callback = function(request)
    if request.match == "CodeCompanionRequestStarted" then
      _G.codecompanion_processing = true
    elseif request.match == "CodeCompanionRequestFinished" then
      _G.codecompanion_processing = false
    end
  end,
})

autocmd("FileType", {
  pattern = "ruby",
  command = "setlocal indentkeys=",
})

autocmd("ColorScheme", {
  pattern = "*bones",
  callback = function()
    require "config.themes.forestbones"
  end,
})

autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

autocmd("FileType", {
  pattern = "python",
  callback = function()
    local venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
    if vim.fn.filereadable(venv_path) == 1 then
      vim.env.VIRTUAL_ENV = vim.fn.getcwd() .. "/.venv"
      vim.env.PATH = vim.fn.getcwd() .. "/.venv/bin:" .. vim.env.PATH
    end
  end,
})
