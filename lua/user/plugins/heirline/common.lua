local utils = require("heirline.utils")

local dim = require("user.plugins.heirline.heirline_utils").dim

local colors = {
  normal_bg = utils.get_highlight("Normal").bg,
  normal_fg = utils.get_highlight("Normal").fg,
  dimmed_bg = dim(utils.get_highlight("Normal").bg, .9),
  bright_bg = utils.get_highlight("Folded").bg,
  bright_fg = utils.get_highlight("Folded").fg,
  term_bg = utils.get_highlight("Added").fg,
  red = utils.get_highlight("DiagnosticError").fg,
  dark_red = utils.get_highlight("DiffDelete").bg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("Constant").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  yellow = utils.get_highlight("DiagnosticWarn").fg,
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("diffDeleted").fg,
  git_add = utils.get_highlight("diffAdded").fg,
  git_change = utils.get_highlight("diffChanged").fg,
}

local icons = {
  close = "󰅙 ", -- ✗   󰅖 󰅘 󰅚 󰅙 󱎘 
  dir = " ", --   󰉋
  lsp = " ", --   
  vim = " ", --           
  git = "󰊢 ", --  󰊢    
  debug = " ",
  rec = " ",
  modified = "● ",
  readonly = " ",
  terminal = "  ",
  linux = " ", -- 󰌽  
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
  bracket_left = "[",
  bracket_right = "]",
}

return { colors = colors, separators = separators, icons = icons }

