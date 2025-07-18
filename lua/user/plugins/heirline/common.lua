local icons = {
  -- ✗   󰅖 󰅘 󰅚 󰅙 󱎘 
  close = "󰅙 ",
  dir = "󰉋 ",
  lsp = " ", --   
  vim = " ", --           
  debug = " ",
  rec = " ",
  modified = "● ",
  readonly = " ",
  terminal = "  ",
  linux = " ",
  windows = " ",
  mac = " ",
  err = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
  warn = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
  info = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
  hint = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
}

local separators = {
  rounded_left = "",
  rounded_right = "",
  rounded_left_hollow = "",
  rounded_right_hollow = "",
  powerline_left = "",
  powerline_right = "",
  powerline_right_hollow = "",
  powerline_left_hollow = "",
  slant_left = "",
  slant_right = "",
  inverted_slant_left = " ",
  inverted_slant_right = "",
  slant_ur = "",
  slant_br = "",
  vert = "│",
  vert_thick = "┃",
  block = "█",
  double_vert = "║",
  dotted_vert = "┊",
}

return { separators = separators, icons = icons }

