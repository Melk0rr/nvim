return {
  -- INFO: Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  -- INFO: Darkrose
  {
    "water-sucks/darkrose.nvim",
    lazy = false,
    priority = 1000,
  },

  -- INFO: Evergarden
  {
    "comfysage/evergarden",
    priority = 1000,
    opts = {
      theme = {
        variant = 'fall', -- 'winter'|'fall'|'spring'
        accent = 'green',
      },
    }
  },

  -- INFO: Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
  },

  -- INFO: Iceberg
  {
    "oahlen/iceberg.nvim",
    priority = 1000,
  },
  -- INFO: Kanagawa
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
  },

  -- INFO: Lavender
  {
    url = "https://codeberg.org/jthvai/lavender.nvim",
    branch = "stable",
    lazy = false,
    priority = 1000,
  },

  -- INFO: Nord
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    priority = 1000,
  },

  -- INFO: Rose pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },

  -- INFO: Tokyonight
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },
}
