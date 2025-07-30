return {
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
      require("user.plugins.heirline_config")
    end,
  },

  -- ===========================================================================
  -- INFO: Whichkey
  -- ===========================================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({ preset = "modern" })
      wk.add({
        -- { "<leader>" , group = "Leader" },
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Show local keymaps", icon = { icon = "󰋖", color = "yellow" } },

        -- NOTE: Buffer group
        { "<leader>b", group = "Buffer" },
        { "<leader>bb", "<cmd>bnext<cr>", desc = "Next Buffer" },
        { "<leader>bB", "<cmd>bnext<cr>", desc = "Previous Buffer" },

        -- NOTE: Debug group
        { "<leader>d", group = "Debug", icon = { icon = "󰃤 ", color = "red" } },

        -- NOTE: Trouble group
        { "<leader>t", group = "Trouble", icon = { icon = " ", color = "yellow" } },

        -- NOTE: Fuzzy finder group
        { "<leader>f", group = "Fuzzy Finder", icon = { icon = "󰭎 ", color = "blue" } },

        -- NOTE: Git group
        { "<leader>g", group = "Git", icon = { icon = " ", color = "orange" } },

        -- NOTE: LSP group
        { "<leader>l", group = "LSP", icon = { icon = " ", color = "green" } },

        -- NOTE: Navigation
        { "<leader>n", group = "Navigation", icon = { icon = "󰎐", color = "yellow" } },

        -- NOTE: Explorer subgroup
        { "<leader>ne", group = "Explorer", icon = { icon = " ", color = "yellow" } },

        -- NOTE: Terminal subgroup
        { "<leader>nt", group = "Terminal", icon = { icon = " ", color = "green" } },

        -- NOTE: Command groups
        { "<leader>:", group = "Commands", icon = { icon = " ", color = "green" } },
        { "<leader>:w", group = "Save", icon = { icon = "󰆓 ", color = "blue" } },
        { "<leader>:q", group = "Quit", icon = { icon = "󰈆 ", color = "red" } },

        -- NOTE: Search group
        { "<leader>s", group = "Search", icon = { icon = " ", color = "blue" } },

        -- NOTE: Text insertion group
        { "<leader>i", group = "Insertion", icon = { icon = "󰗧", color = "blue" } },
      })
    end
  },

  -- ===========================================================================
  -- INFO: Yazi
  -- ===========================================================================
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/snacks.nvim"
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  }
}
