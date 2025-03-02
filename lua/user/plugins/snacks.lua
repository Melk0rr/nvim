return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    -- NOTE: Bigfile
    bigfile = {
      enabled = true,
      notify = true,
    },

    -- NOTE: Buffdelete
    bufdelete = { enabled = true },

    -- NOTE: Dashboard
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

    -- NOTE: Indent
    indent = { enabled = true },

    -- NOTE: Input
    input = {
      enabled = true,
      icon = "",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },

    -- NOTE: Lazygit
    lazygit = {
      configure = true,
      config = {
        gui = {},
        os = {
          disableStartupPopups = true,
        },
      },
      win = {
        height = 0,
      },
    },

    -- NOTE: Notifier
    notifier = {
      enabled = true,
      timeout = 4000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,           -- add 1 cell of left/right padding to the notification window
      sort = { "level", "added" }, -- sort by level and time
      level = vim.log.levels.TRACE,
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
      style = "compact",
      top_down = true,
      date_format = "%R",
      more_format = " ↓ %d lines ",
      refresh = 50,
    },

    -- NOTE: Notify
    notify = { enabled = true },

    -- NOTE: Picker
    -- HACK: Picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    picker = {
      enabled = true,
      focus = "input",
      layout = {
        preset = "telescope",
        cycle = true,
      },
      toggles = {
        follow = "f",
        hidden = "h",
        ignored = "i",
        modified = "m",
        regex = { icon = "R", value = false },
      },
      layouts = {
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.4,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list",    border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, border = "left" },
            },
          },
        },

        select = {
          preview = false,
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.4,
            min_height = 3,
            box = "vertical",
            border = "rounded",
            title = "{title}",
            title_pos = "center",
            { win = "input",   height = 1,          border = "bottom" },
            { win = "list",    border = "none" },
            { win = "preview", title = "{preview}", height = 0.4,     border = "top" },
          },
        },

        telescope = {
          reverse = true,
          layout = {
            box = "horizontal",
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.45,
              border = "rounded",
              title_pos = "center",
            },
          },
        },

        vertical = {
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            border = "rounded",
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input",   height = 1,          border = "bottom" },
            { win = "list",    border = "none" },
            { win = "preview", title = "{preview}", height = 0.4,     border = "top" },
          },
        },
      },
    },

    -- NOTE: Profiler
    profiler = { enabled = true },

    -- NOTE: Quickfile
    quickfile = { enabled = true },

    -- NOTE: Scroll
    scroll = { enabled = false },

    -- NOTE: Statuscolumn
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = false,
        git_hl = false,
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50,
    },

    -- NOTE: Terminal
    terminal = {
      win = {
        height = 0.25,
      },
    },

    toggle = {
      enabled = true,
      map = vim.keymap.set,
      which_key = true,
    },

    -- NOTE: Words
    words = { enabled = true },
  },
}

