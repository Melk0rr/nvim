local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local separators = require("user.plugins.heirline.common").separators
local icons = require("user.plugins.heirline.common").icons

local Mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
  },
  provider = function(self)
    return icons.vim .. "%2(" .. self.mode_names[self.mode] .. "%)"
  end,
  hl = function(self)
    local color = self:mode_color()
    return { fg = color, bold = true }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
}

Mode = utils.surround({ separators.rounded_left, separators.rounded_right }, "bright_bg", {Mode})

local DefaultStatusline = {
    Mode,
    -- Space,
    -- Spell,
    -- WorkDir,
    -- FileNameBlock,
    -- { provider = "%<" },
    -- Space,
    -- Git,
    -- Space,
    -- Diagnostics,
    -- Align,
    -- -- { flexible = 3,   { Navic, Space }, { provider = "" } },
    -- Align,
    -- DAPMessages,
    -- LSPActive,
    -- -- VirtualEnv,
    -- Space,
    -- FileType,
    -- { flexible = 3,   { FileEncoding, Space }, { provider = "" } },
    -- Space,
    -- Ruler,
    -- SearchCount,
    -- Space,
    -- ScrollBar,
}

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
            n = "cyan",
            i = "green",
            v = "blue",
            V = "blue",
            ["\22"] = "blue", -- this is an actual ^V, type <C-v><C-v> in insert mode
            c = "orange",
            s = "pure",
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
    -- TerminalStatusline,
    -- InactiveStatusline,
    DefaultStatusline,
}

return {
  statusline = StatusLines
}

