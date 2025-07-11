return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  enabled = true,
  config = function()
    require("heirline").setup()
  end,
}
