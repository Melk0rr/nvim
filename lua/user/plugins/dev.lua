-- INFO: Multiple plugins for dev QoL
return {
  -- NOTE: Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      trouble = true,
      preview_config = {},
    },
  },

  -- NOTE: Image
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      backend      = "kitty",
      processor    = "magick_cli",
      integrations = {
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
  },

  -- NOTE: Rainbow CSV
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },

  -- NOTE: Render Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      checkbox = { enabled = true },
      completions = { lsp = { enabled = true } },
    }
  },

  -- NOTE: TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },

  -- NOTE: Trouble
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = "<leader>t",
    opts = {
      -- preview = { type = "float" },
      open_no_results = true,
      keys = {
        ["<Tab>"] = "fold_toggle",
      },
      modes = {
        symbols = {
          win = {
            size = 0.2,
          },
          filter = {
            any = {
              kind = {
                "Variable",
                "Class",
                "Constructor",
                "Enum",
                "Field",
                "Function",
                "Interface",
                "Method",
                "Module",
                "Namespace",
                "Package",
                "Property",
                "Struct",
                "Trait",
              },
            },
          },
        },
      },
    },
  },
}
