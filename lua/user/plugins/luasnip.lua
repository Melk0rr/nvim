return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = function(_, opts)
    if opts then require("luasnip").config.setup(opts) end
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })

    local ls = require("luasnip")

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
