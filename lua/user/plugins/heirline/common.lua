local icons = {
    -- ✗   󰅖 󰅘 󰅚 󰅙 󱎘 
    close = "󰅙 ",
    dir = "󰉋 ",
    lsp = " ", --   
    vim = " ",--       
    debug = " ",
    rec = " ",
    modified = "● ",
    readonly = " ",
    terminal = "  ",
    err = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
}

local separators = {
    rounded_left = "",
    rounded_right = "",
    rounded_left_hollow = "",
    rounded_right_hollow = "",
    powerline_left = "",
    powerline_right = "",
    powerline_right_hollow = "",
    powerline_left_hollow = "",
    slant_left = "",
    slant_right = "",
    inverted_slant_left = " ",
    inverted_slant_right = "",
    slant_ur = "",
    slant_br = "",
    vert = "│",
    vert_thick = "┃",
    block = "█",
    double_vert = "║",
    dotted_vert = "┊",
}

return { separators = separators, icons = icons }

