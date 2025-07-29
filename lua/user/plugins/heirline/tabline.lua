local utils = require("heirline.utils")

local cmp = require("user.plugins.heirline.components")

local common = require("user.plugins.heirline.common")
local sep = common.separators
local icons = common.icons
local colors = common.colors

local dim = require("user.plugins.heirline.heirline_utils").dim

-- ===========================================================================
-- INFO: TabLine
-- ===========================================================================
local TablineBufnr = {
  provider = function(self)
    return tostring(self.bufnr) .. ". "
  end,
  hl = "Comment",
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
  provider = function(self)
    -- self.filename will be defined later, just keep looking at the example!
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}

local TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
          or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
    end,
    provider = function(self)
      if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
        return "  "
      else
        return ""
      end
    end,
    hl = { fg = "orange" },
  },
}

local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      local hl_sel = utils.get_highlight("TabLineSel")
      hl_sel.fg = colors["absel_fg"]
      hl_sel.bg = colors["absel_bg"]

      return hl_sel
    else
      local hl = utils.get_highlight("TabLine")
      hl.fg = utils.get_highlight("TabLineSel").bg

      return hl
    end
  end,
  on_click = {
    callback = function(_, minwid, _, button)
      if (button == "m") then -- close on mouse middle click
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
        end)
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
  TablineBufnr,
  cmp.FileIcon,
  TablineFileName,
  TablineFileFlags,
}

local TablineCloseButton = {
  condition = function(self)
    return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
  end,
  { provider = " " },
  {
    provider = icons.close,
    hl = { fg = "gray" },
    on_click = {
      callback = function(_, minwid)
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
          vim.cmd.redrawtabline()
        end)
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_close_buffer_callback",
    },
  },
}

local TablinePicker = {
  condition = function(self)
    return self._show_picker
  end,
  init = function(self)
    local bufname = vim.api.nvim_buf_get_name(self.bufnr)
    bufname = vim.fn.fnamemodify(bufname, ":t")
    local label = bufname:sub(1, 1)
    local i = 2
    while self._picker_labels[label] do
      label = bufname:sub(i, i)
      if i > #bufname then
        break
      end
      i = i + 1
    end
    self._picker_labels[label] = self.bufnr
    self.label = label
  end,
  provider = function(self)
    return self.label
  end,
  hl = { fg = "red", bold = true },
}

local TablineBufferBlock = utils.surround({ sep.slant_left, sep.slant_right }, function(self)
  if self.is_active then
    return colors["absel_bg"]
  else
    return utils.get_highlight("TabLine").bg
  end
end, { TablinePicker, TablineFileNameBlock, TablineCloseButton })

local Tabpage = {
  {
    provider = function(self)
      return " %" .. self.tabnr .. "T" .. self.tabnr .. " "
    end,
    hl = { bold = true },
  },
  {
    provider = function(self)
      local n = #vim.api.nvim_tabpage_list_wins(self.tabpage)
      return n .. "%T "
    end,
    hl = { fg = "gray" },
  },
  hl = function(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end,
  update = { "TabNew", "TabClosed", "TabEnter", "TabLeave", "WinNew", "WinClosed" },
}

local TabpageClose = {
  provider = " %999X" .. icons.close .. "%X",
  hl = "TabLine",
}

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  cmp.Align,
  utils.make_tablist(Tabpage),
  TabpageClose,
}

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    local offset_type = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if offset_type == "neo-tree" or offset_type == "snacks_layout_box" then
      self.title = "󰙅  Files"
      return true
    end
  end,
  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(" ", pad) .. title .. string.rep(" ", pad)
  end,
  hl = function(self)
    if vim.api.nvim_get_current_win() == self.winid then
      return "TablineSel"
    else
      return "Tabline"
    end
  end,
}

local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

local buflist_cache = {}

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
  callback = function(_)
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        buflist_cache[i] = v
      end
      for i = #buffers + 1, #buflist_cache do
        buflist_cache[i] = nil
      end

      -- if #buflist_cache > 1 then
      --   vim.o.showtabline = 2
      -- elseif vim.o.showtabline ~= 1 then       --otheriwise it breaks startup screen
      --   vim.o.showtabline = 1
      -- end

      -- always show tabline as long as there is at least 1 buffer
      if #buflist_cache > 0 then
        vim.o.showtabline = 2
      end
    end)
  end,
})

local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = "", hl = { fg = "gray" } },
  { provider = "", hl = { fg = "gray" } },
  function() return buflist_cache end,
  false
)

return {
  TabLineOffset,
  BufferLine,
  TabPages,
}
