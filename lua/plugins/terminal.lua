return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    -- init = function()
    --   vim.g.tmux_navigator_disable_when_zoomed = 1
    -- end
  },
  {
    "christoomey/vim-tmux-runner",
    cmd = { "VtrSendCommandToRunner", "VtrSendLinesToRunner", "VtrAttachToPane" },
  },
}
