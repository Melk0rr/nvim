local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local separators = require("user.plugins.heirline.common").separators
local cmp = require("user.plugins.heirline.components")

-- ===========================================================================
-- INFO: Wrap up default status line
-- ===========================================================================

Mode = utils.surround({ separators.rounded_left, separators.rounded_right }, "bright_bg", { cmp.Mode })

local DefaultStatusline = {
  Mode,
  cmp.Space,
  cmp.WorkDir,
  cmp.FileNameBlock,
  cmp.Space,
  cmp.Git,
  cmp.Space,
  cmp.Diagnostics,
  cmp.Align,
  cmp.Align,
  cmp.DAPMessages,
  cmp.LSPActive,
  cmp.Space,
  cmp.FileType,
  { flexible = 3, { cmp.FileEncoding, cmp.Space }, { provider = "" } },
  cmp.Space,
  cmp.FileFormat,
  cmp.Space,
  cmp.Ruler,
  cmp.SearchCount,
  cmp.Space,
  cmp.ScrollBar,
}

local TerminalStatusline = {
  condition = function()
    return conditions.buffer_matches({ buftype = { "terminal" } })
  end,
  hl = { bg = "dark_red" },
  { condition = conditions.is_active, Mode, cmp.Space },
  cmp.FileType,
  cmp.Space,
  cmp.TerminalName,
  cmp.Align,
}

-- ===========================================================================
-- INFO: Final status lines
-- ===========================================================================
local StatusLines = {
  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,
  static = {
    mode_colors = {
      n = "red",
      i = "green",
      v = "cyan",
      V = "cyan",
      ["\22"] = "cyan", -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = "orange",
      s = "pure",
      S = "purple",
      ["\19"] = "purple", -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = "orange",
      r = "orange",
      ["!"] = "blue",
      t = "green",
    },
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or "n"
      return self.mode_colors[mode]
    end,
  },
  fallthrough = false,
  -- GitStatusline,
  -- SpecialStatusline,
  -- TerminalStatusline,
  -- InactiveStatusline,
  DefaultStatusline,
}

return {
  statusline = StatusLines
}

