return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/nvim-treesitter-context" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "fish",
        "go",
        "html",
        "hyprlang",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "toml",
        "typescript",
        "vim",
        "yaml"
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<c-backspace>',
        },
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
            [']p'] = '@parameter.outer',
            [']i'] = '@conditional.outer',
            [']l'] = '@loop.outer',
            [']t'] = '@comment.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[p'] = '@parameter.outer',
            ['[i'] = '@conditional.outer',
            ['[l'] = '@loop.outer',
            ['[t'] = '@comment.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['gpj'] = '@parameter.inner',
          },
          swap_previous = {
            ['gpk'] = '@parameter.inner',
          },
        },
      },
    })
    require("treesitter-context").setup()
  end
}
