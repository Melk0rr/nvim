return {
  -- INFO: UI
  require("user.plugins.bufferline"),
  require("user.plugins.ccc"),
  require("user.plugins.illuminate"),
  require("user.plugins.lualine"),
  require("user.plugins.noice"),

  -- INFO: QoL
  require("user.plugins.snacks"),
  require("user.plugins.todo-comments"),
  require("user.plugins.whichkey"),

  -- INFO: LSP / Linting / Completion / Language support
  require("user.plugins.treesitter"),
  require("user.plugins.blink"),
  require("user.plugins.crates"),
  require("user.plugins.inlay-hint"),
  require("user.plugins.lspconfig"),
  require("user.plugins.markdown"),
  require("user.plugins.mason"),
  require("user.plugins.mini"),
  require("user.plugins.rainbowcsv"),
  require("user.plugins.rustaceanvim"),

  -- INFO: Debug
  require("user.plugins.dap"),

  -- INFO: Colorschemes
  require("user.plugins.base16"),
  -- require("user.plugins.gruvbox"),
  -- require("user.plugins.catppuccin"),
  -- require("user.plugins.rosepine"),
  -- require("user.plugins.tokyonight"),
}
