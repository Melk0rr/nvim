return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local on_attach = function(_, bufnr)
      local opts = function(desc)
        return { noremap = true, silent = true, desc = desc }
      end
      local map = vim.keymap.set
      map('n', "<leader>li", vim.lsp.buf.declaration, opts("LSP declaration"))
      map('n', "<leader>lI", vim.lsp.buf.definition, opts("LSP definition"))
      map('n', "<leader>lr", vim.lsp.buf.rename, opts("Rename LSP reference"))
      map('n', "<leader>la", vim.lsp.buf.code_action, opts("LSP code action"))
      map('n', "<leader>lf", vim.lsp.buf.format, opts("LSP format"))
      map('n', "<leader>lh", vim.lsp.buf.hover, opts("LSP hover info"))
      map('n', "<leader>lH", vim.lsp.buf.signature_help, opts("LSP signature help"))
      map('n', "<leader>lk", vim.diagnostic.goto_prev, opts("Previous LSP diagnostic"))
      map('n', "<leader>lj", vim.diagnostic.goto_next, opts("Next LSP diagnostic"))
      map('n', "<leader>ld", "<cmd>Telescope diagnostics<CR>", opts("Telescope LSP diagnostics"))
      map('n', "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts("Telescope LSP document symbols"))
      map('n', "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts("Telescope LSP workspace symbols"))
    end

    lspconfig.bashls.setup({ on_attach = on_attach })                                   -- Bash
    lspconfig.fish_lsp.setup({ on_attach = on_attach })                                 -- Fish
    lspconfig.asm_lsp.setup({ on_attach = on_attach })                                  -- Assembly
    lspconfig.clangd.setup({ on_attach = on_attach })                                   -- C/C++
    lspconfig.rust_analyzer.setup({ on_attach = on_attach })                            -- Rust
    lspconfig.gopls.setup({ on_attach = on_attach })                                    -- Go
    lspconfig.ts_ls.setup({ on_attach = on_attach })                                    -- Typescript/Javascript
    lspconfig.nil_ls.setup({ on_attach = on_attach })                                   -- Nix
    lspconfig.hyprls.setup({ on_attach = on_attach })                                   -- Hyprlang
    lspconfig.markdown_oxide.setup({ on_attach = on_attach })                           -- Markdown
    lspconfig.jsonls.setup({ on_attach = on_attach })

    -- Python
    lspconfig.ruff.setup({
      on_attach = on_attach,
      init_options = {
        settings = {
          configuration = "~/.config/ruff/ruff.toml",
          lineLength = 100,
          indentWidth = 2,
          lint = {
            enable = true,
            ignore = { "E111", "E114", "E121", "E202", "E203", "E501", "E221", "W503", "E241", "E402" },
          }
        }
      }
    })
    lspconfig.pylsp.setup({
      on_attach = on_attach,
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
          }
        }
      }
    })

    -- Lua
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT"
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        })
      end,

      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path path = vim.split(package.path, ";"), }, diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {"vim", "use"},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
        }
      },
    })

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.wgsl",
      callback = function()
        vim.bo.filetype = "wgsl"
      end,
    })
  end,
}
