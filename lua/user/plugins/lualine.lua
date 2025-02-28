return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        icons_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = '',
        disabled_filetypes = { "alpha" },
      },
      sections = {
        lualine_b = { "branch", "diff" },
        lualine_c = {{ "filename", path = 1 }}
      },
    }
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        vim.opt.laststatus = 3
      end,
    })
  end,
}
