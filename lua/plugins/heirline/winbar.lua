local utils = require("heirline.utils")

local dim = require("plugins.heirline.common").dim

local cmp = require("plugins.heirline.components")

-- ===========================================================================
-- INFO: Navic
-- ===========================================================================
local Navic = {
  condition = function()
    return require("nvim-navic").is_available()
  end,
  static = {
    type_hl = {
      File = dim(utils.get_highlight("Directory").fg, 75),
      Module = dim(utils.get_highlight("@module").fg, .75),
      Namespace = dim(utils.get_highlight("@module").fg, .75),
      Package = dim(utils.get_highlight("@module").fg, .75),
      Class = dim(utils.get_highlight("@type").fg, .75),
      Method = dim(utils.get_highlight("@function.method").fg, .75),
      Property = dim(utils.get_highlight("@property").fg, .75),
      Field = dim(utils.get_highlight("@variable.member").fg, .75),
      Constructor = dim(utils.get_highlight("@constructor").fg, .75),
      Enum = dim(utils.get_highlight("@type").fg, .75),
      Interface = dim(utils.get_highlight("@type").fg, .75),
      Function = dim(utils.get_highlight("@function").fg, .75),
      Variable = dim(utils.get_highlight("@variable").fg, .75),
      Constant = dim(utils.get_highlight("@constant").fg, .75),
      String = dim(utils.get_highlight("@string").fg, .75),
      Number = dim(utils.get_highlight("@number").fg, .75),
      Boolean = dim(utils.get_highlight("@boolean").fg, .75),
      Array = dim(utils.get_highlight("@variable.member").fg, .75),
      Object = dim(utils.get_highlight("@type").fg, .75),
      Key = dim(utils.get_highlight("@keyword").fg, .75),
      Null = dim(utils.get_highlight("@comment").fg, .75),
      EnumMember = dim(utils.get_highlight("@constant").fg, .75),
      Struct = dim(utils.get_highlight("@type").fg, .75),
      Event = dim(utils.get_highlight("@type").fg, .75),
      Operator = dim(utils.get_highlight("@operator").fg, .75),
      TypeParameter = dim(utils.get_highlight("@type").fg, .75),
    },
    -- line: 16 bit (65536); col: 10 bit (1024); winnr: 6 bit (64)
    -- local encdec = function(a,b,c) return dec(enc(a,b,c)) end; vim.pretty_print(encdec(2^16 - 1, 2^10 - 1, 2^6 - 1))
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function(self)
    local data = require("nvim-navic").get_data() or {}
    local children = {}
    for i, d in ipairs(data) do
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = { fg = self.type_hl[d.type] },
        },
        {
          provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
          hl = { fg = self.type_hl[d.type] },
          -- hl = self.type_hl[d.type],
          on_click = {
            callback = function(_, minwid)
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
            end,
            minwid = pos,
            name = "heirline_navic",
          },
        },
      }
      if i < #data then
        table.insert(child, {
          provider = " → ",
          hl = { fg = "bright_fg" },
        })
      end
      table.insert(children, child)
    end
    self[1] = self:new(children, 1)
  end,
  update = "CursorMoved",
  hl = { fg = "gray" },
}

return {
  Navic,
  cmp.Align
}

