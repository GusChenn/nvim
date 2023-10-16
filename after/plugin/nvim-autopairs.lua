local helpers = require('user.helpers')
local autopairs = helpers.SafeRequire('nvim-autopairs')
local cmp = helpers.SafeRequire('cmp')
local cmp_autopairs = helpers.SafeRequire('nvim-autopairs.completion.cmp')

if autopairs then
  autopairs.setup {
      check_ts = true,
      ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
      },
      disable_filetype = { "TelescopePompt", "spectre_panel" },
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey='Comment',
      },
  }
end

if cmp and cmp_autopairs then
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
