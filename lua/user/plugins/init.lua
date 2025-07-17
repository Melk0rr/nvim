return {
  -- INFO: UI
  require("user.plugins.ui"),

  -- INFO: QoL
  require("user.plugins.image"),
  require("user.plugins.snacks"),
  require("user.plugins.todo-comments"),
  require("user.plugins.whichkey"),
  require("user.plugins.yazi"),

  -- INFO: LSP / Linting / Language support
  require("user.plugins.crates"),
  require("user.plugins.inlay-hint"),
  require("user.plugins.lspconfig"),
  require("user.plugins.markdown"),
  require("user.plugins.mason"),
  require("user.plugins.mini"),
  require("user.plugins.rainbowcsv"),
  require("user.plugins.treesitter"),

  -- INFO: Completion & Snippets
  require("user.plugins.blink"),
  require("user.plugins.luasnip"),

  -- INFO: Debug
  require("user.plugins.debug"),

  -- INFO: Colorschemes
  require("user.plugins.colorschemes"),
}
