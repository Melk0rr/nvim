local home = os.getenv("HOME")
package.path = package.path .. ';' .. home .. "/.config/nvim/lua?.lua"
vim.opt.runtimepath:append(home .. "/.config/nvim/")

require("user.options")
require("user.lazy")
require("user.autocmd")
require("user.mappings")

-- HACK: handling theme based on hyde
-- INFO: Function to read config file
local function read_config(file_path)
  local handle = io.open(file_path, 'r')
  if not handle then
    error("Cannot open hyde config file: " .. file_path)
  end

  local content = handle:read("*a")
  handle.close(file_path)

  return content
end

-- INFO: Function to extract hyde theme
local function get_hyde_theme(content)
  for line in content:gmatch("[^\n]") do
    local theme = line:match('hydeTheme="([^"]+)"')
    if theme then
      return theme
    end
  end
  return nil
end

-- INFO: Function to change colorscheme based on hyde theme
local function set_colorscheme(file_path)
  local content = read_config(file_path)
  if content then
    local theme = get_hyde_theme(content)
    if theme then
      -- TODO: handle different colorschemes
    else
      print("Failed to read hyde conf")
    end

  end
end

local hyde_conf = os.getenv("HOME") .. "/.config/hyde/hyde.conf"
set_colorscheme(hyde_conf)

