return {
  -- INFO: UI
  require("user.plugins.ui"),

  -- INFO: QoL
  require("user.plugins.snacks"),
  require("user.plugins.whichkey"),
  require("user.plugins.yazi"),

  -- INFO: Dev tools
  require("user.plugins.dev"),

  -- INFO: LSP & Language support
  require("user.plugins.lspconfig"),
  require("user.plugins.mason"),

  -- INFO: Syntax, Completion & Snippets
  require("user.plugins.completion"),
  require("user.plugins.mini"),
  require("user.plugins.snippets"),
  require("user.plugins.treesitter"),

  -- INFO: Debug
  require("user.plugins.debug"),

  -- INFO: Colorschemes
  require("user.plugins.colorschemes"),
}
