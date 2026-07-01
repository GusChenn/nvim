local M = {
  a = 1,
  b = 2,
  c = {
    d = {
      f = 3
    }
  }
}

M.something = true

M.other = false

local S = {}

S.hello = "Hello, World!"

M.other
