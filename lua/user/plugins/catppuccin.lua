return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 99,
  config = function()
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}
