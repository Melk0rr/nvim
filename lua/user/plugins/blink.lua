return {
  "saghen/blink.cmp",
  version = "1.*",
  lazy = false,
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
      menu = { auto_show = true, border = "single" },
      ghost_text = { enabled = true },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          -- Configure markdown_oxide for better keyword matching
          markdown_oxide = {
            keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
          },
        },
      }
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
