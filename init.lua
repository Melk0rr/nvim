local home = os.getenv("HOME")
package.path = package.path .. ';' .. home .. "/.config/nvim/lua?.lua"
vim.opt.runtimepath:append(home .. "/.config/nvim/")

require("config.options")
require("config.lazy")
require("config.autocmd")
require("config.mappings")
require("config.theme")
