local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local separators = require("user.plugins.heirline.common").separators
local icons = require("user.plugins.heirline.common").icons

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

-- ===========================================================================
-- INFO: File
-- ===========================================================================
local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color =
        require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
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
      return { fg = utils.get_highlight("Directory").fg, bold = true, italic = true }
    end
    return "Directory"
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
  FileIcon,
  FileName,
  unpack(FileFlags),
}

local WorkDir = {
  init = function(self)
    self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. icons.dir
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#self.cwd, 0.27) then
      self.cwd = vim.fn.pathshorten(self.cwd)
    end
  end,
  hl = { fg = "blue", bold = true },
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
      return self.icon .. self.cwd .. trail .. " "
    end,
  },
  {
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. cwd .. trail .. " "
    end,
  },
  {
    provider = "",
  },
}

local FileType = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  FileIcon,
  {
    provider = function()
      return string.upper(vim.bo.filetype)
    end,
    hl = "Type",
  }
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc ~= "utf-8" and enc:upper()
  end,
}

local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt == "dos" and icons.windows or fmt == "mac" and icons.mac or icons.linux
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
    callback = function(self, minwid, nclicks, button)
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
      return " " .. self.status_dict.head
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
    hl = "diffAdded",
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = "diffDeleted",
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = "diffChanged",
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
    return icons.lsp .. "[" .. table.concat(names, " ") .. "]"
  end,
  hl        = { fg = "green", bold = true },
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
-- INFO: Wrap up default status line
-- ===========================================================================

local Align = { provider = "%=" }
local Space = { provider = " " }

Mode = utils.surround({ separators.rounded_left, separators.rounded_right }, "bright_bg", { Mode })

local DefaultStatusline = {
  Mode,
  Space,
  WorkDir,
  FileNameBlock,
  Space,
  Git,
  Space,
  Diagnostics,
  Align,
  Align,
  DAPMessages,
  LSPActive,
  Space,
  FileType,
  { flexible = 3, { FileEncoding, Space }, { provider = "" } },
  Space,
  FileFormat,
  Space,
  -- Ruler,
  -- SearchCount,
  -- Space,
  -- ScrollBar,
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

