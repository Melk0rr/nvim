return {
  "neovim/nvim-lspconfig",
  ft = { "asm", "bash", "c", "cpp", "fish", "go", "javascript", "lua", "python", "rust", "yaml" },
  config = function()
    local lspconfig = require("lspconfig")

    -- INFO: On attach function
    local on_attach = function(_, bufnr)
      local opts = function(desc)
        return { noremap = true, silent = true, desc = desc }
      end

      local map = vim.keymap.set
      map("n", "<leader>li", vim.lsp.buf.declaration, opts("LSP declaration"))
      map("n", "<leader>lI", vim.lsp.buf.definition, opts("LSP definition"))
      map("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename LSP reference"))
      map("n", "<leader>la", vim.lsp.buf.code_action, opts("LSP code action"))
      map("n", "<leader>lf", vim.lsp.buf.format, opts("LSP format"))
      map("n", "<leader>lh", vim.lsp.buf.hover, opts("LSP hover info"))
      map("n", "<leader>lH", vim.lsp.buf.signature_help, opts("LSP signature help"))
      map("n", "<leader>lk", vim.diagnostic.goto_prev, opts("Previous LSP diagnostic"))
      map("n", "<leader>lj", vim.diagnostic.goto_next, opts("Next LSP diagnostic"))
    end

    -- INFO: Capabilities
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- INFO: Bash
    lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities, filetypes = { "bash", "sh", "zsh" } })

    -- INFO: CSS
    lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Fish
    lspconfig.fish_lsp.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Assembly
    lspconfig.asm_lsp.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: C/C++
    lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Rust
    -- lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities, cmd = { "rustup", "run", "stable", "rust-analyzer" } })

    -- INFO: Go
    lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Javascript / Typescript
    lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: JSON
    lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Nix
    -- lspconfig.nil_ls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Hyprlang
    lspconfig.hyprls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Markdown
    lspconfig.markdown_oxide.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Python
    lspconfig.ruff.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        settings = {
          configuration = "~/.config/ruff/ruff.toml",
          lineLength = 100,
          indentWidth = 2,
          lint = {
            enable = true,
            ignore = { "E111", "E114", "E121", "E202", "E203", "E501", "E221", "W503", "E241", "E402" },
          },
        },
      },
    })
    lspconfig.pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            autopep8 = { enabled = false },
            black = { enabled = false },
            yapf = { enabled = false },
            mccabe = { enabled = false },
            pyflakes = { enabled = false },
            flake8 = { enabled = false },
            pycodestyle = {
              enabled = false,
              -- ignore = { "E111", "E114", "E121", "E202", "E203", "E501", "E221", "W503", "E241", "E402" },
              -- maxLineLength = 100,
              -- indentSize = 2,
            },
          },
        },
      },
    })

    -- INFO: Lua
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        })
      end,

      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path path = vim.split(package.path, ";"), }, diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim", "use" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
        },
      },
    })

    -- HACK: Change diagnostics symbols
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.wgsl",
      callback = function()
        vim.bo.filetype = "wgsl"
      end,
    })
  end,
}

