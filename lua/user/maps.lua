local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- Fundamentals
keymap("", "<Space>", "<Nop>", opts)
keymap("n", "<C-l>", ":noh<cr>", opts)
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("n", "<C-x>", ":bd!<cr>", opts)
keymap("v", "<leader>s", "*<ESC>", opts)
keymap("v", "Y", '"+y', opts)

-- Nvim tree
keymap("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", opts)

-- Navigation
keymap("n", "<A-k>", ":wincmd k<cr>", opts)
keymap("n", "<A-h>", ":wincmd h<cr>", opts)
keymap("n", "<A-j>", ":wincmd j<cr>", opts)
keymap("n", "<A-l>", ":wincmd l<cr>", opts)
keymap("n", "<leader>wv", ":vsplit<cr>", opts)
keymap("n", "<leader>wh", ":split<cr>", opts)
keymap("n", "ff", ":Telescope find_files<cr>", opts)
keymap("n", "fg", ":Telescope live_grep<cr>", opts)
keymap("n", "fb", ":Telescope buffers<cr>", opts)
keymap("n", "fh", ":Telescope help_tags<cr>", opts)
keymap("n", "<leader>?", ":lua require'telescope.builtin'.keymaps{}<cr>", opts)

-- Telescope
keymap('v', 'fg', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', opts)

-- Lsp
-------------------------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', 'g p', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'g n', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
---------------------------------------

-- BufferLine
vim.keymap.set('n', '<leader>1', ":lua require('bufferline').go_to(1, true)<cr>", opts)
vim.keymap.set('n', '<leader>2', ":lua require('bufferline').go_to(2, true)<cr>", opts)
vim.keymap.set('n', '<leader>3', ":lua require('bufferline').go_to(3, true)<cr>", opts)
vim.keymap.set('n', '<leader>4', ":lua require('bufferline').go_to(4, true)<cr>", opts)
vim.keymap.set('n', '<leader>5', ":lua require('bufferline').go_to(5, true)<cr>", opts)
vim.keymap.set('n', '<leader>6', ":lua require('bufferline').go_to(6, true)<cr>", opts)
vim.keymap.set('n', '<leader>7', ":lua require('bufferline').go_to(7, true)<cr>", opts)
vim.keymap.set('n', '<leader>l', ":BufferLineCycleNext<cr>", opts)
vim.keymap.set('n', '<leader>h', ":BufferLineCyclePrev<cr>", opts)
vim.keymap.set('n', '<leader>p', ":BufferLineTogglePin<cr>", opts)
vim.keymap.set('n', '<leader>fl', ":BufferLineMoveNext<cr>", opts)
vim.keymap.set('n', '<leader>fh', ":BufferLineMovePrev<cr>", opts)

-- Lspsaga
vim.keymap.set('n', 'gr', ":Lspsaga finder ref<cr>", opts)
vim.keymap.set('n', 'gt', ":Lspsaga peek_definition<cr>", opts)
vim.keymap.set('n', 'gd', ":Lspsaga goto_definition<cr>", opts)
vim.keymap.set('n', 'gh', ":Lspsaga hover_doc<cr>", opts)
vim.keymap.set('n', 'gl', ":Lspsaga diagnostic_jump_next<cr>", opts)

-- Resize mode
vim.keymap.set('n', '<leader>r', ":lua require('resize-mode').start()<cr>", opts)

-- Cheatsheet
keymap("n", "cc", ":Cheatsheet!<cr>", opts)
