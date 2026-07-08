local function rails_setup()
  vim.pack.add({
    "https://github.com/tpope/vim-rails"
  })

  local function toggleTestFile()
    local current_file = vim.fn.expand("%:p")
    local test_file = string.gsub(current_file, "/app/", "/test/"):gsub("%.rb$", "_test.rb")
    local is_test_file = string.match(current_file, "/test/") ~= nil

    if is_test_file then
      local file = string.gsub(current_file, "/test/", "/app/"):gsub("_test%.rb$", ".rb")

      vim.cmd("edit " .. file)
    else
      if test_file ~= "" then
        vim.cmd("edit " .. test_file)
      else
        print("No corresponding test file found.")
      end
    end
  end

  vim.keymap.set("n", "<leader>tt", toggleTestFile, { noremap = true, silent = true })
end


vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("my.Rails", { clear = true }),
  once = true,
  pattern = 'ruby',
  callback = rails_setup,
})
