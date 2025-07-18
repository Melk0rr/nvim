local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local separators = require("user.plugins.heirline.common").separators
local components = require("user.plugins.heirline.components")

-- ===========================================================================
-- INFO: Wrap up default status line
-- ===========================================================================

Mode = utils.surround({ separators.rounded_left, separators.rounded_right }, "bright_bg", { Mode })

local DefaultStatusline = {
  components.Mode,
  components.Space,
  components.WorkDir,
  components.FileNameBlock,
  components.Space,
  components.Git,
  components.Space,
  components.Diagnostics,
  components.Align,
  components.Align,
  components.DAPMessages,
  components.LSPActive,
  components.Space,
  components.FileType,
  { flexible = 3, { components.FileEncoding, components.Space }, { provider = "" } },
  components.Space,
  components.FileFormat,
  components.Space,
  components.Ruler,
  components.SearchCount,
  components.Space,
  components.ScrollBar,
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

