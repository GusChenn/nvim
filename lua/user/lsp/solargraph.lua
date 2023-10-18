local helpers = require('user.helpers')
local lspconfig = helpers.SafeRequire('lspconfig')

if lspconfig then
  lspconfig.solargraph.setup {}
end
