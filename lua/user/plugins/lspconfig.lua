return {
  "neovim/nvim-lspconfig",
  ft = { "asm", "bash", "c", "cpp", "fish", "go", "html", "javascript", "lua", "markdown", "python", "rust", "typescript", "yaml" },
  opts = { inlay_hints = { enabled = true } },
  config = function()
    local lspconfig = require("lspconfig")
    local lsp_util = require('lspconfig.util')

    -- INFO: On attach function
    local on_attach = function(client, _)
      local opts = function(desc)
        return { noremap = true, silent = true, desc = desc }
      end

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
      end

      local map = vim.keymap.set
      map("n", "<leader>li", vim.lsp.buf.declaration, opts("LSP declaration"))
      map("n", "<leader>lI", vim.lsp.buf.definition, opts("LSP definition"))
      map("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename LSP reference"))
      map("n", "<leader>la", vim.lsp.buf.code_action, opts("LSP code action"))
      map("n", "<leader>lf", vim.lsp.buf.format, opts("LSP format"))
      map("n", "<leader>lh", vim.lsp.buf.hover, opts("LSP hover info"))
      map("n", "<leader>lH", vim.lsp.buf.signature_help, opts("LSP signature help"))
      map("n", "<leader>lk", function() vim.diagnostic.jump({ count = -1, float = true }) end,
        opts("Previous LSP diagnostic"))
      map("n", "<leader>lj", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts("Next LSP diagnostic"))
      map('n', "<leader>l?", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        opts("LSP toggle inlay hints"))

      if client.name == "markdown_oxide" then
        vim.api.nvim_create_user_command(
          "Daily",
          function(args)
            local input = args.args

            client.exec_cmd({ command = "jump", arguments = { input } })
          end,
          { desc = 'Open daily note', nargs = "*" }
        )
      end
    end

    -- INFO: Capabilities
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- INFO: Bash
    lspconfig.bashls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "bash", "sh", "zsh" }
    })

    -- INFO: CSS
    lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Emmet
    lspconfig.emmet_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "php" },
      init_options = {
        includeLanguages = {
          md = "html",
          php = "html"
        },
        showAbbreviationSuggestions = true,
        showExpandedAbbreviation = "always",
        showSuggestionsAsSnippets = true,
      },
    })

    -- INFO: Fish
    lspconfig.fish_lsp.setup({ on_attach = on_attach, capabilities = capabilities, filetypes = { "fish" } })

    -- INFO: Assembly
    lspconfig.asm_lsp.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: C/C++
    lspconfig.clangd.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        clangd = {
          InlayHints = {
            Designators = true,
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
          },
        }
      }
    })

    -- INFO: Rust
    -- lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities, cmd = { "rustup", "run", "stable", "rust-analyzer" } })

    -- INFO: Go
    lspconfig.gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
          }
        }
      }
    })

    -- INFO: Javascript / Typescript
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      }
    })

    -- INFO: JSON
    lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Nix
    -- lspconfig.nil_ls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Hyprlang
    lspconfig.hyprls.setup({ on_attach = on_attach, capabilities = capabilities })

    -- INFO: Markdown
    lspconfig.markdown_oxide.setup({
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        }
      ),
      on_attach = on_attach,
      commands = {
        Today = {
          function(client)
            client.exec_cmd({ command = "jump", arguments = { "today" } })
          end,
          description = "Open today's daily note"
        },
        Tomorrow = {
          function(client)
            client.exec_cmd({ command = "jump", arguments = { "tomorrow" } })
          end,
          description = "Open tomorrow's daily note"
        },
        Yesterday = {
          function(client)
            client.exec_cmd({ command = "jump", arguments = { "yesterday" } })
          end,
          description = "Open yesterday's daily note"
        },
      },
    })
    -- lspconfig.marksman.setup({ on_attach = on_attach, capabilities = capabilities, filetypes = { "markdown" }})

    -- INFO: Python
    lspconfig.ruff.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        settings = {
          configuration = "~/.config/ruff/ruff.toml",
          lineLength = 100,
          lint = {
            enable = true,
            select = { "D", "E", "F", "W", "A", "PLC", "PLE", "PLW", "I" },
            ignore = { "D200", "D202", "D203", "D212", "D406", "D407", "D413", "E111", "E114", "E121", "E202", "E203", "E501", "E221", "W503", "E241", "E402" },
          },
        },
      },
    })

    -- lspconfig.pylsp.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   settings = {
    --     pylsp = {
    --       plugins = {
    --         autopep8 = { enabled = false },
    --         black = { enabled = false },
    --         yapf = { enabled = false },
    --         mccabe = { enabled = false },
    --         pyflakes = { enabled = false },
    --         flake8 = { enabled = false },
    --         pycodestyle = { enabled = false, maxLineLength = 100 },
    --       },
    --     },
    --   },
    -- })

    lspconfig.basedpyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetype = { "python" },
      settings = {                       -- see https://docs.basedpyright.com/latest/configuration/language-server-settings/
        basedpyright = {
          disableLanguageServices = false,
          disableOrganizeImports = true, -- use ruff instead of it
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true, -- auto serach command paths like 'src'
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportUnknownMemberType = false,
            }
          }
        },
      },
      -- handlers = {
      -- 	['textDocument/publishDiagnostics'] = create_custom_handler(sign_priority.rank1)
      -- }
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
          hint = { enable = true },
        },
      },
    })
  end,
}
