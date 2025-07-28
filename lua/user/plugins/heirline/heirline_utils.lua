local utils = require("heirline.utils")

--- Blend two rgb colors using alpha
---@return table style style elements based on the file type
local function file_style()
  local filename = vim.api.nvim_buf_get_name(0)
  local extension = vim.fn.fnamemodify(filename, ":e")
  local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

  return { filename = filename, icon = icon, icon_color = icon_color }
end

--- Blend two rgb colors using alpha
---@param color1 string | number first color
---@param color2 string | number second color
---@param alpha number (0, 1) float determining the weighted average
---@return string color hex string of the blended color
local function blend(color1, color2, alpha)
  color1 = type(color1) == "number" and string.format("#%06x", color1) or color1
  color2 = type(color2) == "number" and string.format("#%06x", color2) or color2
  local r1, g1, b1 = color1:match("#(%x%x)(%x%x)(%x%x)")
  local r2, g2, b2 = color2:match("#(%x%x)(%x%x)(%x%x)")
  local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
  local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
  local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
  return "#"
      .. string.format("%02x", math.min(255, math.max(r, 0)))
      .. string.format("%02x", math.min(255, math.max(g, 0)))
      .. string.format("%02x", math.min(255, math.max(b, 0)))
end

local function dim(color, n)
  return blend(color, "#000000", n)
end

local function diag_color()
  local diagnostics = vim.diagnostic.count()
  local severities = {
    error = diagnostics[vim.diagnostic.severity.ERROR],
    warn = diagnostics[vim.diagnostic.severity.WARN],
    info = diagnostics[vim.diagnostic.severity.INFO],
    hint = diagnostics[vim.diagnostic.severity.HINT],
  }

  if severities.error and severities.error >= 1 then
    return utils.get_highlight("DiagnosticError").fg
  elseif severities.warn and severities.warn >= 1 then
    return utils.get_highlight("DiagnosticWarn").fg
  elseif severities.info and severities.info >= 1 then
    return utils.get_highlight("DiagnosticInfo").fg
  elseif severities.hint and severities.hint >= 1 then
    return utils.get_highlight("DiagnosticHint").fg
  else
    return utils.get_highlight("String").fg
  end
end

local function file_enc()
  return (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
end

return { dim = dim, file_style = file_style, diag_color = diag_color, file_enc = file_enc }

