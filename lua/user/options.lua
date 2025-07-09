-- ===========================================================================
-- NOTE: Tabulation
-- ===========================================================================
vim.opt.expandtab = true -- tab to space

-- ===========================================================================
-- WARN: Can be overwritten by lsp
-- ===========================================================================
vim.opt.tabstop = 2 -- tab size
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smartcase = true

-- ===========================================================================
-- NOTE: Line
-- ===========================================================================
vim.opt.cursorline = true
vim.opt.number = true -- HACK: line number
vim.opt.fillchars = { eob = ' ' }

-- ===========================================================================
-- NOTE: Window splitting and buffers
-- ===========================================================================
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.o.hidden = true

vim.o.switchbuf = "useopen"

-- ===========================================================================
-- NOTE: Folds
-- ===========================================================================
vim.opt.foldlevel = 999 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
-- vim.opt.foldmethod = "indent"
vim.opt.foldmethod = "expr"
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""

  -- HACK: Removes fill chars
  vim.opt.fillchars:append({ fold = " " })
else
  vim.opt.foldmethod = "indent"
end

-- ===========================================================================
-- NOTE: Trailing whitespace
-- ===========================================================================

vim.o.list = true
vim.opt.listchars = {
  extends = "»",
  nbsp = "⣿",
  precedes = "«",
  trail = "·",
  -- removed tab, it's too noisy
  tab = "  ", -- this must be two chars, see :h listchars
}

-- ===========================================================================
-- NOTE: File search
-- ===========================================================================
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ===========================================================================
-- NOTE: Status
-- ===========================================================================
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.showmode = false

vim.opt.ch = 0

-- ===========================================================================
-- NOTE: Term
-- ===========================================================================
vim.g.terminal_emulator = "ghostty"

vim.cmd "colorscheme vim" -- WARN: overwritten by plugins color scheme
--vim.cmd "set background=dark"
vim.opt.termguicolors = true

-- HACK: Keep consistency between neovim and term bg color
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})

-- ===========================================================================
-- NOTE: Miscellaneous
-- ===========================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.pumheight = 40
vim.lsp.inlay_hint.enable(true)


-- ===========================================================================
-- HACK: Change diagnostics symbols
-- ===========================================================================
vim.diagnostic.config {
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    }
  }
}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})
