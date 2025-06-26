return {
  "saghen/blink.cmp",
  version = "1.*",
  lazy = false,
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
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
        snippets = {
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath('config') .. '/snippets' },
          }
        },
      }
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true }
  },
}
