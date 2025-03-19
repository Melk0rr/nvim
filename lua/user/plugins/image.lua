return {
  "3rd/image.nvim",
  build = false,   -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    integrations  = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
        filetypes = { "markdown", "vimwiki", "html" },
      },
      html = {
        enabled = true,
        only_render_image_at_cursor = true,
        filetypes = { "html", "xhtml", "htm", "markdown" }
      },
      css = {
        enabled = true
      }
    }
  }
}
