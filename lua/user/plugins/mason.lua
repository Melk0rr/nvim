return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    -- INFO: servers to install
    local servers = {
      "bashls",
      "clangd",
      "cssls",
      "emmet_language_server",
      "gopls",
      "html",
      "hyprls",
      "jsonls",
      "lua_ls",
      "markdown_oxide",
      "pylsp",
      "ruff",
      "rust_analyzer",
      "ts_ls",
    }

    -- INFO: Mason setup
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- INFO: Mason lsp setup
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
      automatic_enable = false
    })
  end
}
