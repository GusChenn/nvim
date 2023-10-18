local helpers = require('user.helpers')
local lspconfig = helpers.SafeRequire('lspconfig')
local cmp = helpers.SafeRequire('cmp_nvim_lsp')

-- if cmp and lspconfig then
--   lspconfig.tsserver.setup {
--     capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
--     on_attach = function(client)
--       client.resolved_capabilities.document_formatting = false
--     end
--   }
-- end
