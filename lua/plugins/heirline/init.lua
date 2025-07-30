return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  enabled = true,
  config = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local colors = require("plugins.heirline.common").colors
    vim.o.laststatus = 3
    vim.o.showcmdloc = "statusline"

    local function setup_colors() return colors end
    require("heirline").setup({
      statusline = require("plugins.heirline.statusline"),
      winbar = require("plugins.heirline.winbar"),
      tabline = require("plugins.heirline.tabline"),
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
  end,
}
