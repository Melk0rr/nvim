return {
  "rebelot/heirline.nvim",
  dev = true,
  -- event = "VimEnter",
  event = "BufEnter",
  enabled = true,
  config = function()
    require("plugins.heirline").setup()
  end,
}
