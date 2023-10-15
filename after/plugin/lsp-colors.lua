local status, colors = pcall(require, 'lsp-colors')
if (not status) then
    print("Somthing went wrong with lsp-colors")
    return
end

local dracula_status, dracula = pcall(require, 'dracula')
if (not dracula_status) then
    print("Somthing went wrong with dracula on lsp-colors")
    return
end

local dracula_colors = dracula.colors()

colors.setup {
  Error = dracula_colors.bright_magenta,
  Warning = dracula_colors.bright_yellow,
  Information = dracula_colors.bright_green,
  Hint = dracula_colors.bright_cyan,
}
