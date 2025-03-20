local home = os.getenv 'HOME'
package.path = package.path .. ';' .. home .. '/.config/nvim/lua?.lua'
vim.opt.runtimepath:append(home .. '/.config/nvim/')

require("user.options")
require("user.lazy")
require("user.autocmd")
require("user.mappings")

-- HACK: handling theme based on hyde
-- INFO: Function to read config file
function read_config(file_path)
  local handle = io.open(file_path, 'r')
  if not handle then
    error("Cannot open hyde config file: " .. file_path)
  end

  local content = handle:read("*a")
  handle.close()

  return content
end

-- INFO: Function to extract hyde theme
function get_hyde_theme(content)
  for line in content:gmatch("[^\n]") do
    local theme = line:match('hydeTheme="([^"]+)"')
    if theme then
      return theme
    end
  end
  return nil
end

local hyde_conf = os.getenv("HOME") .. "/.config/hyde/hyde.conf"

