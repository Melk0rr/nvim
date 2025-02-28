return {
  "saecki/crates.nvim",
  ft = {"toml"},
  config = function ()
    require("crates").setup({
      completion = {
        cmp = {
          enable = true
        }
      }
    })
  end
}
