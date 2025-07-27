local conditions = require("heirline.conditions")

local colors = require("user.plugins.heirline.common").colors
local icons = require("user.plugins.heirline.common").icons
local dim = require("user.plugins.heirline.common").dim
local file_style = require("user.plugins.heirline.common").file_style
local cmp = require("user.plugins.heirline.components")

-- ===========================================================================
-- INFO: Wrap up status line
-- ===========================================================================

local Mode = cmp.PillWrapper(
  { {
    provider = icons.vim,
    hl = function(self)
      return {
        bg = colors[self:mode_color()],
        fg = dim(
          colors[self:mode_color()], .4)
      }
    end
  } },
  { { cmp.Mode, hl = function(self) return { bg = dim(colors[self:mode_color()], .4), fg = colors[self:mode_color()] } end } },
  false
)

local WorkDir = cmp.PillWrapper(
  { { provider = icons.dir, hl = { fg = dim(colors["yellow"], .4), bg = colors["yellow"] } } },
  { { cmp.WorkDir, hl = { fg = colors["yellow"], bg = dim(colors["yellow"], .4) } } },
  false
)

local FileNameBlock = cmp.PillWrapper(
  {
    {
      init = function(self)
        local fstyle = file_style()

        self.filename = fstyle.filename
        self.icon_color = dim(fstyle.icon_color, .4)
      end,
      cmp.FileIcon,
      hl = function() return { bg = file_style().icon_color } end
    }
  },
  {
    { cmp.Space, hl = function() return { bg = dim(file_style().icon_color, .4) } end },
    {
      cmp.FileNameBlock,
      hl = function()
        return {
          fg = file_style().icon_color,
          bg = dim(file_style().icon_color, .4)
        }
      end
    }
  },
  false
)
--
local Git = cmp.PillWrapper(
  { { provider = icons.git, hl = { fg = dim(colors["orange"], .4), bg = colors["orange"] } } },
  { { cmp.Git, hl = { fg = colors["orange"], bg = dim(colors["orange"], .4) } } },
  false
)

local LspDiag = cmp.PillWrapper(
  { { cmp.Diagnostics, hl = function() return conditions.has_diagnostics() and { bg = "bright_bg" } or { bg = "normal_bg" } end } },
  {
    { cmp.LSPActive,        hl = { fg = dim(colors["green"], .4), bg = colors["green"] } },
    { provider = " " .. icons.lsp, hl = { fg = dim(colors["green"], .4), bg = colors["green"] } }
  },
  true
)

local DefaultStatusline = {
  Mode,
  cmp.Space,
  WorkDir,
  cmp.Space,
  FileNameBlock,
  cmp.Space,
  Git,
  cmp.Align,
  cmp.Align,
  cmp.DAPMessages,
  LspDiag,
  cmp.Space,
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
local ExplorerStatusline = {
  condition = function()
    local ft = vim.bo.filetype
    return ft == "snacks_picker_list" or ft == "snacks_picker_input"
  end,
  Mode,
  cmp.Space,
  WorkDir,
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
  ExplorerStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

return StatusLines

