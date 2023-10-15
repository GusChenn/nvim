local status, autopairs = pcall(require, 'nvim-autopairs')
if (not status) then
    print("Somthing went wrong with autopairs")
    return
end

local status, cmp = pcall(require, 'cmp')
if (not status) then
    print("Somthing went wrong with cmp on autopairs config")
    return
end

local status, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if (not status) then
    print("Somthing went wrong with cmp_autopairs")
    return
end

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

-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )
