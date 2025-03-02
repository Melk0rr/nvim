return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Bigfile
    bigfile = { enabled = true },

    -- Dashboard
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },

    -- Indend
    indent = { enabled = true },

    -- Lazygit
    lazygit = {
      configure = true,
      config = {
        gui = {

        },
        os = {
          disableStartupPopups = true,
        }
      },
      win = {
        height = 0,
      },
    },

    -- Notifier
    notifier = { enabled = false },

    -- Quickfile
    quickfile = { enabled = true },

    -- Scroll
    scroll = { enable = true },

    -- Terminal
    terminal = {
      win = {
        height = 0.25,
      }
    },

    -- Words
    words = { enabled = true },
  },
  keys = {
    { "<leader>a" , function() Snacks.dashboard() end, desc = "Snacks dashboard" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>tn", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
}
