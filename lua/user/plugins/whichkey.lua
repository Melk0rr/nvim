return {
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

      -- NOTE: Yank group
      { "<leader>y", group = "Yank", icon = { icon = " ", color = "blue" } },
    }
    )
  end
}
