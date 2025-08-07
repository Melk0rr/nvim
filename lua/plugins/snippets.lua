return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")
    ls.config.setup({ enable_autosnippets = true })

    local map = vim.keymap.set
    map({ 'i', 's' }, "<A-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    map({ 'i', 's' }, "<A-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    -- Friendly snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Custom snippets
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })

    -- Documentation snippets
    ls.filetype_extend("cs", { "csharpdoc" })
    ls.filetype_extend("c", { "cdoc" })
    ls.filetype_extend("cpp", { "cppdoc" })
    ls.filetype_extend("javascript", { "jsdoc" })
    ls.filetype_extend("lua", { "luadoc" })
    ls.filetype_extend("python", { "pydoc" })
    ls.filetype_extend("rust", { "rustdoc" })
    ls.filetype_extend("sh", { "shelldoc" })
    ls.filetype_extend("typescript", { "tsdoc" })
  end
}
