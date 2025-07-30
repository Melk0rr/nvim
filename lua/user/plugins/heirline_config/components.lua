local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local common = require("user.plugins.heirline_config.common")
local icons = common.icons
local sep = common.separators
local colors = common.colors

local dim = common.dim
local file_style = common.file_style
local file_enc = common.file_enc

local function fmt(color)
  if type(color) == "string" then
    return color
  elseif type(color) == "number" then
    return string.format("#%06x", color)
  end
end

-- ===========================================================================
-- INFO: Utility components
-- ===========================================================================
local Align = { provider = "%=" }
local Space = { provider = " " }

--- Wrap the provided components with a pill icon
--- @param left table the icon of the pill.
--- @param right table the components to wrap.
--- @param reversed boolean wheither to mirror the component or not
--- @return table PillWrap the returned object.
local function PillWrapper(left, right, reversed)
  if reversed == nil then
    reversed = false
  end

  local result = {
    insert = function(self, item)
      table.insert(self.content, item)
    end,
    content = {},
  }

  local function bg(color, self)
    if not color then
      color = {}
    end

    if (type(color)) == "function" then
      local color_func = color
      color = color_func(self)
    end

    if not color.bg then
      local fg = color.fg
      if not fg then
        fg = "bright_bg"
      end

      if colors[fg] ~= nil then
        fg = colors[fg]
      end

      color.bg = dim(fmt(fg), .4)
    end

    return fmt(color.bg)
  end

  local prev_color = {}
  for i, item in ipairs(left) do
    if not item.condition or item.condition() ~= false then
      if i == 1 then
        result:insert({
          provider = sep.rounded_left,
          hl = function(self)
            return { fg = bg(item.hl, self) }
          end
        })
      end
      result:insert(item)
      prev_color = item.hl
    end
  end

  local last_left_color = prev_color

  for i, item in ipairs(right) do
    if not item.condition or item.condition() ~= false then
      if i == 1 then
        result:insert({
          provider = function() return reversed and sep.rounded_left or sep.rounded_right end,
          hl = function(self)
            if reversed then
              return { fg = bg(item.hl, self), bg = bg(last_left_color, self) }
            end

            return { fg = bg(last_left_color, self), bg = bg(item.hl, self) }
          end
        })
      end
      result:insert(item)
      prev_color = item.hl
    end
  end

  result:insert({
    provider = sep.rounded_right,
    hl = function(self)
      return { fg = bg(prev_color, self) }
    end
  })

  return result.content
end

-- ===========================================================================
-- INFO: Mode
-- ===========================================================================
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
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
  provider = function(self)
    return "%2(" .. self.mode_names[self.mode] .. "%)"
  end,
  hl = function(self)
    local color = self:mode_color()
    return { fg = color, bold = true }
  end
}

-- ===========================================================================
-- INFO: File
-- ===========================================================================
local FileIcon = {
  init = function(self)
    local fstyle = file_style()

    self.icon = fstyle.icon
    self.icon_color = self.icon_color and self.icon_color or fstyle.icon_color
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then
      self.lfilename = "[No Name]"
    end
    if not conditions.width_percent_below(#self.lfilename, 0.27) then
      self.lfilename = vim.fn.pathshorten(self.lfilename)
    end
  end,
  hl = function()
    if vim.bo.modified then
      return { bold = true, italic = true }
    end

    return { bold = false, italic = false }
  end,
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

-- INFO: File flag (modified/readonly)
local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = " " .. icons.modified,
    hl = { fg = "green" },
    on_click = {
      callback = function(_, minwid)
        local buf = vim.api.nvim_win_get_buf(minwid)
        local bufname = vim.api.nvim_buf_get_name(buf)
        vim.cmd.write(bufname)
      end,
      minwid = function()
        return vim.api.nvim_get_current_win()
      end,
      name = "heirline_write_buf",
    },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = icons.readonly,
    hl = { fg = "orange" },
  },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  FileName,
  unpack(FileFlags),
}

local WorkDir = {
  init = function(self)
    self.icon = " " .. (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " "
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#self.cwd, 0.27) then
      self.cwd = vim.fn.pathshorten(self.cwd)
    end
  end,
  hl = { bold = true },
  on_click = {
    callback = function()
      vim.cmd([[lua Snacks.picker.explorer()]])
    end,
    name = "heirline_workdir",
  },
  flexible = 1,
  {
    provider = function(self)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. self.cwd .. trail
    end,
  },
  {
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. cwd .. trail
    end,
  }
}

local FileType = {
  {
    provider = function()
      return string.upper(vim.bo.filetype)
    end,
    hl = "Type",
  }
}

local FileEncoding = {
  condition = function()
    return file_enc() ~= "utf-8"
  end,
  provider = function()
    return file_enc():upper()
  end,
}

local FileFormat = {
  hl = { bold = true },
  provider = function()
    local format = vim.bo.fileformat
    return format == "dos" and icons.windows or format == "mac" and icons.mac or icons.linux
  end
}

-- ===========================================================================
-- INFO: Git
-- ===========================================================================
local Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  on_click = {
    -- Callback arguments: self, minwid, nclicks, button
    callback = function(_)
      vim.defer_fn(function()
        vim.cmd([[lua require("snacks").lazygit()]])
      end, 100)
    end,
    name = "heirline_git",
    update = false,
  },
  hl = { fg = "orange" },
  {
    provider = function(self)
      return "  " .. self.status_dict.head
    end,
    hl = { bold = true },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = utils.get_highlight("diffAdded").fg },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = utils.get_highlight("diffDeleted").fg },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = utils.get_highlight("diffChanged").fg },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
  },
}

-- ===========================================================================
-- INFO: Diagnostics
-- ===========================================================================
local Diagnostics = {
  condition = conditions.has_diagnostics,
  update = { "DiagnosticChanged", "BufEnter" },
  on_click = {
    callback = function()
      require("trouble").toggle("diagnostics")
    end,
    name = "heirline_diagnostics",
  },
  init = function(self)
    self.diagnostics = vim.diagnostic.count()
  end,
  {
    provider = function(self)
      return self.diagnostics[vim.diagnostic.severity.ERROR] and (icons.err .. self.diagnostics[1] .. " ")
    end,
    hl = "DiagnosticError",
  },
  {
    provider = function(self)
      return self.diagnostics[vim.diagnostic.severity.WARN] and (icons.warn .. self.diagnostics[2] .. " ")
    end,
    hl = "DiagnosticWarn",
  },
  {
    provider = function(self)
      return self.diagnostics[vim.diagnostic.severity.INFO] and (icons.info .. self.diagnostics[3] .. " ")
    end,
    hl = "DiagnosticInfo",
  },
  {
    provider = function(self)
      return self.diagnostics[vim.diagnostic.severity.HINT] and (icons.hint .. self.diagnostics[4] .. " ")
    end,
    hl = "DiagnosticHint",
  },
}

-- ===========================================================================
-- INFO: DAP
-- ===========================================================================
local DAPMessages = {
  condition = function()
    local session = require("dap").session()
    return session ~= nil
  end,
  provider = function()
    return icons.debug .. require("dap").status() .. " "
  end,
  hl = "Debug",
  {
    provider = " ",
    on_click = {
      callback = function()
        require("dap").step_into()
      end,
      name = "heirline_dap_step_into",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function()
        require("dap").step_out()
      end,
      name = "heirline_dap_step_out",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function()
        require("dap").step_over()
      end,
      name = "heirline_dap_step_over",
    },
  },
  { provider = " " },
  {
    provider = " ",
    hl = { fg = "green" },
    on_click = {
      callback = function()
        require("dap").run_last()
      end,
      name = "heirline_dap_run_last",
    },
  },
  { provider = " " },
  {
    provider = " ",
    hl = { fg = "red" },
    on_click = {
      callback = function()
        require("dap").terminate()
        require("dapui").close({})
      end,
      name = "heirline_dap_close",
    },
  },
  { provider = " " },
  --       ﰇ  
}

-- ===========================================================================
-- INFO: LSPActive
-- ===========================================================================
local LSPActive = {
  condition = conditions.lsp_attached,
  update    = { "LspAttach", "LspDetach", "WinEnter" },
  provider  = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return table.concat(names, " ")
  end,
  on_click  = {
    name = "heirline_LSP",
    callback = function()
      vim.schedule(function()
        vim.cmd([[LspInfo]])
      end)
    end,
  },
}

-- ===========================================================================
-- INFO: Ruler
-- ===========================================================================
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c",
}

local FilePerc = {
  provider = "%P"
}

-- ===========================================================================
-- INFO: SearchCount
-- ===========================================================================
local SearchCount = {
  condition = function()
    return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  provider = function(self)
    local search = self.search
    return string.format(" %d/%d", search.current, math.min(search.total, search.maxcount))
  end,
  hl = { fg = "purple", bold = true },
}

-- ===========================================================================
-- INFO: Scrollbar
-- ===========================================================================
local ScrollBar = {
  static = {
    -- sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
    sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = "blue", bg = "bright_bg" },
}

-- ===========================================================================
-- INFO: Terminal
-- ===========================================================================
local TerminalName = {
  -- icon = ' ', -- 
  {
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
      return vim.bo.filetype ~= "yazi" and tname or "yazi"
    end,
    hl = { bold = true },
  },
  { provider = " - " },
  {
    provider = function()
      return vim.b.term_title
    end,
  },
}


-- ===========================================================================
-- INFO: Export
-- ===========================================================================
return {
  Space = Space,
  Align = Align,
  PillWrapper = PillWrapper,
  Mode = Mode,
  FileIcon = FileIcon,
  FileName = FileName,
  FileFlags = FileFlags,
  FileNameBlock = FileNameBlock,
  FileFormat = FileFormat,
  FileEncoding = FileEncoding,
  FileType = FileType,
  WorkDir = WorkDir,
  Git = Git,
  Diagnostics = Diagnostics,
  DAPMessages = DAPMessages,
  LSPActive = LSPActive,
  Ruler = Ruler,
  FilePerc = FilePerc,
  SearchCount = SearchCount,
  ScrollBar = ScrollBar,
  TerminalName = TerminalName,
}
