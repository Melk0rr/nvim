local map = vim.keymap.set
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Common
map('', 'Y', 'y$', opts("Yank whole line"))
map('n', '<leader;', 'mqA;<esc>`q', opts("Semicolon at end of line"))
map('n', '<leader>h', '<cmd>noh<cr>', opts("No search highlight"))
map('n', '<leader>zz', '<cmd>wqa!<cr>', opts("Save and quit"))
map('n', '<C-a>', 'goVG', opts("Select all"))

-- Press jk fast to exit insert mode
map('i', 'jk', '<ESC>', opts("jk to exit insert mode"))
map('i', 'kj', '<ESC>', opts("kj to exit insert mode"))

-- Window navigation
map('n', '<C-h>', '<C-w>h', opts("Go to left window"))
map('n', '<C-j>', '<C-w>j', opts("Go to lower window"))
map('n', '<C-k>', '<C-w>k', opts("Go to upper window"))
map('n', '<C-l>', '<C-w>l', opts("Go to right window"))
map('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts("Go to left terminal"))
map('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts("Go to lower terminal"))
map('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts("Go to upper terminal"))
map('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts("Go to right terminal"))

-- Buffer navigation
map('n', '<Tab>', '<cmd>bnext<cr>', opts("Next buffer"))
map('n', '<S-Tab>', '<cmd>bprevious<cr>', opts("Previous buffer"))

-- Stay in indent mode
map('v', '<', '<gv^', opts("Unindent"))
map('v', '>', '>gv^', opts("Indent"))

-- Move lines
map('n', '<A-j>', ':m .+1<cr>==', opts("Move line down"))
map('n', '<A-k>', ':m .-2<cr>==', opts("Move line up"))
map('v', '<A-j>', ":m '>+1<cr>gv=gv", opts("Move selection down"))
map('v', '<A-k>', ":m '<-2<cr>gv=gv", opts("Move selection up"))

-- Plugin-specific
-- search
local telescope = require("telescope.builtin")
map('n', '<leader>ff', telescope.find_files, opts("Telescope find files"))
map('n', '<leader>fr', telescope.oldfiles, opts("Telescope find recent files"))
map('n', '<leader>fk', telescope.keymaps, opts("Telescope find keymaps"))
map('n', '<leader>fC', telescope.commands, opts("Telescope find commands"))
map('n', '<leader>fg', telescope.grep_string, opts("Telescope grep string"))
map('n', '<leader>fG', telescope.live_grep, opts("Telescope live grep"))
map('n', '<leader>fP', '<cmd>Telescope projects<cr>', opts("Telescope projects"))

-- git
map('n', '<leader>gB', telescope.git_branches, opts("Telescope git branches"))
map('n', '<leader>gc', telescope.git_commits, opts("Telescope git commits"))
map('n', '<leader>gs', telescope.git_status, opts("Telescope git status"))

-- neo-tree
map('n', '<leader>e', '<cmd>Neotree toggle<cr>', opts("Toggle neo tree"))
