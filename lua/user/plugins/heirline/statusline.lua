local conditions = require("heirline.conditions")

local colors = require("user.plugins.heirline.common").colors
local icons = require("user.plugins.heirline.common").icons
local cmp = require("user.plugins.heirline.components")

-- ===========================================================================
-- INFO: Wrap up default status line
-- ===========================================================================

local Mode = cmp.PillWrapper(icons.vim, function(self) return colors[self:mode_color()] end, cmp.Mode)
local WorkDir = cmp.PillWrapper(icons.dir, colors["yellow"], { cmp.WorkDir, hl = { fg = "yellow" } })

local DefaultStatusline = {
  Mode,
  cmp.Space,
  WorkDir,
  cmp.Space,
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

local InactiveStatusline = {
  condition = conditions.is_not_active,
  { hl = { fg = "gray", force = true }, cmp.WorkDir },
  cmp.FileNameBlock,
  { provider = "%<" },
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
      n = "blue",
      i = "green",
      v = "cyan",
      V = "cyan",
      ["\22"] = "cyan", -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple", -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = "orange",
      r = "orange",
      ["!"] = "red",
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
  TerminalStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

return StatusLines

