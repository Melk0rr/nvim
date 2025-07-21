return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "moyiz/blink-emoji.nvim" },
    lazy = false,
    opts = {
      keymap = {
        preset    = "default",
        -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        -- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"]  = { "accept", "fallback" },
        ["<A-k>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<A-j>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-k>"] = { "scroll_documentation_up", "fallback" },
        ["<S-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },
      completion = {
        keyword = { range = "full" },
        list = {
          selection = { preselect = false },
        },
        menu = { auto_show = true, border = "rounded" },
        ghost_text = { enabled = true },
        documentation = {
          auto_show = true,
          window = { border = "rounded" }
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji" },
        providers = {
          path = { fallbacks = { "snippets", "buffer" } },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
          }
        }
      },
      snippets = { preset = "luasnip" },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" }
  },
  {
    "felpafel/inlay-hint.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = "LspAttach",
    config = function()
      require("inlay-hint").setup({
        virt_text_pos = "inline",
        highlight_group = "LspInlayHint",
      })
    end
  },

  -- NOTE: Mini - Autopair
  {
    "echasnovski/mini.pairs",
    version = '*',
    opts = {
      modes = { insert = true, command = false, terminal = true },
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
      },
    }
  },

  -- NOTE: Mini - Comment
  {
    "echasnovski/mini.comment",
    version = '*',
  },

  -- NOTE: Mini - Surround
  {
    "echasnovski/mini.surround",
    version = '*',
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      }
    }
  },
}
