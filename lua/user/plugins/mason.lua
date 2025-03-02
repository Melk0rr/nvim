return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    -- INFO: servers to install
    local servers = {
      "bashls",
      "clangd",
      "cssls",
      "gopls",
      "html",
      "hyprls",
      "jsonls",
      "lua_ls",
      "markdown_oxide",
      "marksman",
      "pylsp",
      "ruff",
      "rust_analyzer",
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
    })
  end
}

