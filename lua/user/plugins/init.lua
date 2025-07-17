return {
  -- INFO: UI
  require("user.plugins.ui"),

  -- INFO: QoL
  require("user.plugins.snacks"),
  require("user.plugins.whichkey"),
  require("user.plugins.yazi"),

  -- INFO: Dev tools
  require("user.plugins.dev"),

  -- INFO: LSP / Linting / Language support
  require("user.plugins.lspconfig"),
  require("user.plugins.markdown"),
  require("user.plugins.mason"),
  require("user.plugins.mini"),
  require("user.plugins.treesitter"),

  -- INFO: Completion & Snippets
  require("user.plugins.completion"),
  require("user.plugins.snippets"),

  -- INFO: Debug
  require("user.plugins.debug"),

  -- INFO: Colorschemes
  require("user.plugins.colorschemes"),
}
