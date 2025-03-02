local home = os.getenv 'HOME'
package.path = package.path .. ';' .. home .. '/nixos-config/modules/home/nvim/lua/?.lua'
vim.opt.runtimepath:append(home .. '/nixos-config/modules/home/nvim/')

require("user.options")
require("user.lazy")
require("user.autocmd")
require("user.mappings")
