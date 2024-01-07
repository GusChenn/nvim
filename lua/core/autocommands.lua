local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd

local exist, user_config = pcall(require, "user.user_config")
local group = exist and type(user_config) == "table" and user_config.autocommands or {}
local enabled = require("core.utils.utils").enabled

-- enables suport for inlay hints with virtual text
if enabled(group, "inlay_hints") then
  cmd("LspAttach", {
    group = augroup("LspAttach_inlayhints", { clear = true }),
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      require("lsp-inlayhints").on_attach(client, bufnr)
    end,
  })
end

-- Fixes some bugs with how treesitter manages folds
if enabled(group, "treesitter_folds") then
  cmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
    desc = "fix tree sitter folds issue",
    group = augroup("treesitter folds", { clear = true }),
    pattern = { "*" },
    callback = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  })
end

-- Removes any trailing whitespace when saving a file
if enabled(group, "trailing_whitespace") then
  cmd({ "BufWritePre" }, {
    desc = "remove trailing whitespace on save",
    group = augroup("remove trailing whitespace", { clear = true }),
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
  })
end

-- remembers file state, such as cursor position and any folds
if enabled(group, "remember_file_state") then
  augroup("remember file state", { clear = true })
  cmd({ "BufWinLeave" }, {
    desc = "remember file state",
    group = "remember file state",
    pattern = { "*.*" },
    command = "mkview",
  })
  cmd({ "BufWinEnter" }, {
    desc = "remember file state",
    group = "remember file state",
    pattern = { "*.*" },
    command = "silent! loadview",
  })
end

-- enables coloring hexcodes and color names in css, jsx, etc.
if enabled(group, "css_colorizer") then
  cmd({ "Filetype" }, {
    desc = "activate colorizer",
    pattern = "css,scss,html,xml,svg,js,jsx,ts,tsx,php,vue",
    group = augroup("colorizer", { clear = true }),
    callback = function()
      require("colorizer").attach_to_buffer(0, {
        mode = "background",
        css = true,
      })
    end,
  })
end

-- disables autocomplete in some filetypes
if enabled(group, "cmp") then
  cmd({ "FileType" }, {
    desc = "disable cmp in certain filetypes",
    pattern = "gitcommit,gitrebase,text,markdown",
    group = augroup("cmp_disable", { clear = true }),
    command = "lua require('cmp').setup.buffer { enabled = false}",
  })
end

-- fixes Trouble not closing when last window in tab
cmd("BufEnter", {
  group = vim.api.nvim_create_augroup("TroubleClose", { clear = true }),
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
        layout[1] == "leaf"
        and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "Trouble"
        and layout[3] == nil
    then
      vim.cmd("confirm quit")
    end
  end,
})