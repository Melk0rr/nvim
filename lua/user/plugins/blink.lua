return {
  "saghen/blink.cmp",
  version = "1.*",
  lazy = false,
  opts = {
    keymap = {
      preset       = "default",
      -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      -- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"]     = { "accept", "fallback" },
      ["<A-k>"]    = { "select_prev", "snippet_backward", "fallback" },
      ["<A-j>"]    = { "select_next", "snippet_forward", "fallback" },
      ["<C-up>"]   = { "scroll_documentation_up", "fallback" },
      ["<C-down>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"]    = { "hide", "fallback" },
    },
    completion = {
      keyword = { range = "full" },
      list = {
        selection = { preselect = false },
      },
      menu = { auto_show = true, border = "rounded" },
      ghost_text = { enabled = true },
      documentation = { auto_show = true },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        path = {
          fallbacks = { "snippets", "buffer" }
        }
      }
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
