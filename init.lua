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


