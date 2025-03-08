-- INFO: Tabulation
vim.opt.expandtab = true		          -- tab to space

-- WARN: Can be overwritten by lsp
vim.opt.tabstop = 2			              -- tab size
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smartcase = true

-- INFO: Line
vim.opt.cursorline = true
vim.opt.number = true 			          -- HACK: line number
vim.opt.fillchars = { eob = ' ' }

-- INFO: Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- INFO: Folds
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
-- vim.opt.foldmethod = "indent"
vim.opt.foldmethod = "expr"
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
else
  vim.opt.foldmethod = "indent"
end

-- INFO: File search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- INFO: Status
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.showmode = false

vim.opt.ch = 0

-- INFO: Term
vim.g.terminal_emulator = "kitty"

-- INFO: Term colors
vim.cmd "colorscheme vim" 		        -- WARN: overwritten by plugins color scheme
--vim.cmd "set background=dark"
vim.opt.termguicolors = true

-- INFO: Miscellaneous
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.pumheight = 40
vim.lsp.inlay_hint.enable(true)

