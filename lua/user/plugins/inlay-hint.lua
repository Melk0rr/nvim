return {
  "felpafel/inlay-hint.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  event = "LspAttach",
  config = function ()
    require("inlay-hint").setup({
      virt_text_pos = "inline",
      highlight_group = "LspInlayHint",
    })
  end
}
