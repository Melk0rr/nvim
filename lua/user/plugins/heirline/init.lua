local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = require("user.plugins.heirline.common").colors

local function setup_colors() return colors end

vim.o.laststatus = 3
vim.o.showcmdloc = "statusline"
-- vim.o.showtabline = 2

require("heirline").setup({
  statusline = require("user.plugins.heirline.statusline"),
  winbar = require("user.plugins.heirline.winbar"),
  -- tabline = require("plugins.heirline.tabline"),
  -- statuscolumn = require("plugins.heirline.statuscolumn"),
  opts = {
    disable_winbar_cb = function(args)
      if vim.bo[args.buf].filetype == "snacks_picker_list" then
        return
      end
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
        filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
      }, args.buf)
    end,
    colors = setup_colors,
  },
})

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.cmd([[au Heirline FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
  group = "Heirline",
})

