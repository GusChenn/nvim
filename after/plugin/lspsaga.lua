local status, lspsaga = pcall(require, 'lspsaga')
if (not status) then
  print("Somthing went wrong with lspsaga")
  return
end

lspsaga.setup {
  diagnostic = {
    keys = {
      quit = { 'q', '<ESC>' }
    }
  },
  ui = {
    code_action = "☰"
  }
}


