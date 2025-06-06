local home = os.getenv("HOME")
package.path = package.path .. ';' .. home .. "/.config/nvim/lua?.lua"
vim.opt.runtimepath:append(home .. "/.config/nvim/")

require("user.options")
require("user.lazy")
require("user.autocmd")
require("user.mappings")
require("user.theme")
