-- Style customization
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { bg="NONE", underline=true, cterm={ underline=true } })
    -- vim.api.nvim_set_hl(0, "LineNr", { bg="NONE", bold=false })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg="NONE", bold=true, cterm={ bold=true } })

    -- Plugin:Illuminate
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { standout=true })
  end,
})

