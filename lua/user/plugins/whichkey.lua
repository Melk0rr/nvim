return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({ preset = "modern" })
    wk.add({
      -- { "<leader>" , group = "Leader" },
      { "<leader>?" , function () require("which-key").show({ global = false }) end, desc = "Show local keymaps", icon = { icon = "󰋖", color = "yellow" } },

      -- NOTE: Buffer group
      { "<leader>b", group = "Buffer" },
      { "<leader>bb", "<cmd>bnext<cr>", desc = "Next Buffer" },
      { "<leader>bB", "<cmd>bnext<cr>", desc = "Previous Buffer" },

      -- NOTE: Debug group
      { "<leader>d", group = "Debug", icon = { icon = "󰃤", color = "red" } },

      -- NOTE: Debug group
      { "<leader>e", group = "Explorer", icon = { icon = "", color = "yellow" } },

      -- NOTE: Fuzzy finder group
      { "<leader>f", group = "Fuzzy Finder", icon = { icon = "󰭎", color = "blue" } },

      -- NOTE: Git group
      { "<leader>g", group = "Git", icon = { icon = "", color = "orange" } },

      -- NOTE: LSP group
      { "<leader>l", group = "LSP", icon = { icon = "", color = "green" } },

      -- NOTE: Quit group
      { "<leader>q", group = "Quit", icon = { icon = "󰈆", color = "red" } },

      -- NOTE: Search group
      { "<leader>s", group = "Search", icon = { icon = "", color = "blue" } },

      -- NOTE: Terminal group
      { "<leader>t", group = "Terminal", icon = { icon = "", color = "green" } },
    }
  )
  end
}

