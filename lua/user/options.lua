-- INFO: Tabulation
vim.opt.expandtab = true		          -- tab to space

-- WARN: Can be overwritten by lsp
vim.opt.tabstop = 2			          -- tab size
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
vim.g.terminal_emulator = "ghostty"

-- INFO: Term colors
vim.cmd "colorscheme vim" 		        -- WARN: overwritten by plugins color scheme
--vim.cmd "set background=dark"
vim.opt.termguicolors = true

-- INFO: Miscellaneous
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.pumheight = 40
vim.lsp.inlay_hint.enable(true)

