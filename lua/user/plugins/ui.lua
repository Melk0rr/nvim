return {
  -- ===========================================================================
  -- INFO: Bufferline
  -- ===========================================================================
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local function diagnostics_indicator(_, _, diagnostics, _)
        local result = {}
        local symbols = {
          error = "",
          warning = "",
          info = "",
        }
        for name, count in pairs(diagnostics) do
          if symbols[name] and count > 0 then
            table.insert(result, symbols[name] .. " " .. count)
          end
        end
        result = table.concat(result, " ")
        return #result > 0 and result or ""
      end

      require("bufferline").setup({
        options = {
          highlights = {
            background = {
              italic = true,
            },
            buffer_selected = {
              bold = true,
            },
          },
          indicator = { style = "underline" },
          close_command = function(bufnum) require("user.plugins.snacks").bufdelete(bufnum) end,
          middle_mouse_command = function(bufnum) require("user.plugins.snacks").bufdelete(bufnum) end,
          close_icon = "",
          themable = true,
          auto_toggle_bufferline = true,
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = diagnostics_indicator,
          offsets = {
            {
              filetype = "neo-tree",
              text = "󰙅  Files",
              separator = true,
              highlight = "Directory",
            },
            {
              filetype = "snacks_layout_box",
              text = "󰙅  Files",
              separator = true,
              highlight = "Directory",
            },
          },
          always_show_bufferline = true,
          sort_by = "id",
          debug = { logging = false },
        },
      })
    end,
  },

  -- ===========================================================================
  -- INFO: CCC color picker
  -- ===========================================================================
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        }
      })
    end
  },

  -- ===========================================================================
  -- INFO: Noice better cmdline
  -- ===========================================================================
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          progress = { enabled = true },
          -- INFO: Override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        views = {
          cmdline_popup = {
            position = {
              row = "45%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = "60%",
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
    end,
  },

  -- ===========================================================================
  -- INFO: Heirline
  -- ===========================================================================
  {
    "rebelot/heirline.nvim",
    event = "BufEnter",
    enabled = true,
    config = function()
      require("user.plugins.heirline")
    end,
  },

  -- ===========================================================================
  -- INFO: Lualine
  -- ===========================================================================
  {
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
          lualine_c = { { "filename", path = 1 } }
        },
      }
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          vim.opt.laststatus = 3
        end,
      })
    end,
  }
}
