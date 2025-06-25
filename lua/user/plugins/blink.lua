return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
  },
  version = '*',
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      keyword = { range = "full" },
      list = {
        selection = { preselect = false },
      },
      menu = { auto_show = true },
    },
    ghost_text = { enabled = true },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          fallbacks = { "snippets", "buffer" }
        }
      }
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true }
  },
}
