return {
  -- NOTE: Autopair
  {
    "echasnovski/mini.pairs",
    version = '*',
    opts = {
      modes = { insert = true, command = false, terminal = true },
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
      },
    }
  },

  -- NOTE: Comment
  {
    "echasnovski/mini.comment",
    version = '*',
  },

  -- NOTE: Surround
  {
    "echasnovski/mini.surround",
    version = '*',
    opts = {
      mappings = {
        add = "gsa",                -- Add surrounding in Normal and Visual modes
        delete = "gsd",             -- Delete surrounding
        find = "gsf",               -- Find surrounding (to the right)
        find_left = "gsF",          -- Find surrounding (to the left)
        highlight = "gsh",          -- Highlight surrounding
        replace = "gsr",            -- Replace surrounding
        update_n_lines = "gsn",     -- Update `n_lines`
      }
    }
  },
}
