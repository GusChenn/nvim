local helpers = require('user.helpers')
local autotag = helpers.SafeRequire('nvim-ts-autotag')

if autotag then
  autotag.setup {}
end
