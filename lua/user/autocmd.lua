-- INFO: Style customization
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { bg="NONE", underline=true, cterm={ underline=true } })
    --vim.api.nvim_set_hl(0, "LineNr", { bg="NONE", bold=false })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg="NONE", bold=true, cterm={ bold=true } })

    -- HACK: Remove folded background
    vim.api.nvim_set_hl(0, "Folded", { bg="NONE" })

    -- HACK: Plugin:Illuminate
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { standout=true })

  end,
})

local theme = require("base16-colorscheme")

local indscope = theme.colors.base07
local bright = theme.colors.base0F
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()

		-- HACK: Snack indent scope
		vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = indscope })

		-- HACK: Bufferline
		vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { sp = bright })
		vim.api.nvim_set_hl(0, "TabLineSel", { bg = bright })
	end,
})
