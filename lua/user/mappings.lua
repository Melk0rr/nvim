-- TODO: use vim api
-- local api = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- ===========================================================================
-- NOTE: Commands
-- ===========================================================================
map('n', "<leader>:qq", "<cmd>qa!<cr>", opts("Flip the table quit"))
map('n', "<leader>:wqq", "<cmd>wqa!<cr>", opts("Save and quit"))

-- ===========================================================================
-- NOTE: Yank
-- ===========================================================================
map('n', "gA", "ggVG", { desc = "Select all" })
map('n', 'Y', "yy", opts("Yank whole line"))
map({ 'n', 'v' }, "<C-c>", '"+y', opts("Yank to clipboard"))
map({ 'n', 'v' }, "<C-a>", ":%+y<cr>", opts("Yank the whole file"))

-- ===========================================================================
-- NOTE: Text insertion
-- ===========================================================================
map('n', "<leader>iL", "i<cr><esc>", opts("Insert line break"))
map('n', "<leader>ip", "ma$p`a", opts("Insert print at the end of the line"))
map('n', "<leader>i;", "mqA;<esc>`q", opts("Insert semicolon at end of line"))

-- ===========================================================================
-- NOTE: Custom motions
-- ===========================================================================
for _, char in ipairs({ '/', '\\', '|', ':', ';', ',', '.', ' ' }) do
  map('n', "vi" .. char, "<cmd>normal! T" .. char .. "vt" .. char .. "<cr>", opts("inner " .. char))
  map('n', "ci" .. char, "<cmd>normal! T" .. char .. "ct" .. char .. "<cr>li", opts("inner " .. char))
  map('n', "di" .. char, "<cmd>normal! T" .. char .. "dt" .. char .. "<cr>", opts("inner " .. char))
  map('n', "yi" .. char, "<cmd>normal! T" .. char .. "yt" .. char .. "<cr>", opts("inner " .. char))
end

-- ===========================================================================
-- NOTE: Press jk fast to exit insert mode
-- ===========================================================================
map('i', "jk", "<ESC>", opts("jk to exit insert mode"))
map('i', "kj", "<ESC>", opts("kj to exit insert mode"))


-- ===========================================================================
-- NOTE: Buffer navigation
-- ===========================================================================
map('n', "<leader>bh", "<cmd>bprevious<cr>", opts("Buffer - previous"))
map('n', "<leader>bl", "<cmd>bnext<cr>", opts("Buffer - next"))
map('n', "<leader>bd", "<cmd>lua require('snacks').bufdelete()<cr>", opts("Buffer - delete current"))
map('n', "<leader>bo", "<cmd>lua require('snacks').bufdelete.other()<cr>", opts("Buffer - delete others"))
map('n', "<leader>ba", "<cmd>lua require('snacks').bufdelete.all()<cr>", opts("Buffer - delete all"))
map("n", "<leader>bp", function()
  local tabline = require("heirline").tabline
  local buflist = tabline._buflist[1]
  buflist._picker_labels = {}
  buflist._show_picker = true
  vim.cmd.redrawtabline()
  local char = vim.fn.getcharstr()
  local bufnr = buflist._picker_labels[char]
  if bufnr then
    vim.api.nvim_win_set_buf(0, bufnr)
  end
  buflist._show_picker = false
  vim.cmd.redrawtabline()
end, { desc = "Buffer - picker" })

-- ===========================================================================
-- NOTE: Stay in indent mode
-- ===========================================================================
map('v', '<', "<gv", opts("Unindent"))
map('v', '>', ">gv", opts("Indent"))

-- ===========================================================================
-- NOTE: Move lines
-- ===========================================================================
map('n', "<A-j>", ":m .+1<cr>==", opts("Move line down"))
map('n', "<A-k>", ":m .-2<cr>==", opts("Move line up"))
map('v', "<A-j>", ":m '>+1<cr>gv=gv", opts("Move selection down"))
map('v', "<A-k>", ":m '<-2<cr>gv=gv", opts("Move selection up"))

-- ===========================================================================
-- NOTE: Debugging
-- ===========================================================================
map('n', "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts("Debugger toggle breakpoint"))
map('n', "<leader>dc", "<cmd>lua require('dap').continue()<cr>", opts("Debugger continue"))
map('n', "<leader>dj", "<cmd>lua require('dap').step_over()<cr>", opts("Debugger step over"))
map('n', "<leader>dk", "<cmd>lua require('dap').step_out()<cr>", opts("Debugger step out"))
map('n', "<leader>dl", "<cmd>lua require('dap').step_into()<cr>", opts("Debugger step into"))
map({ 'n', 't' }, "<leader>dm",
  "<cmd>lua require('snacks').terminal.open({'make'}, { win = { position = 'bottom' } })<cr>",
  opts("Debugger run C make"))
map('n', "<leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<cr>", opts("Debugger run rust tests"))
map('n', "<leader>dx", "<cmd>lua require('dap').terminate()<cr><cmd>lua require('dapui').close()<cr>",
  opts("Debugger terminate"))

-- ===========================================================================
-- NOTE: Trouble
-- ===========================================================================
map("n", "<leader>tt", "<cmd>Trouble<CR>")
map("n", "<leader>tx", "<cmd>Trouble diagnostics toggle<CR>")
map("n", "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>")
map("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<CR>")
map("n", "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=bottom win.relative=win win.size=.5<CR>")
map("n", "<leader>tQ", "<cmd>Trouble qflist toggle<CR>")
map("n", "<leader>tL", "<cmd>Trouble loclist toggle<CR>")
-- ===========================================================================
-- NOTE: Git
-- ===========================================================================
map('n', "<leader>gb", "<cmd>lua require('snacks').git.blame_line()<cr>", opts("Git blame Line"))
map('n', "<leader>gB", "<cmd>lua require('snacks').picker.git_branches()<cr>", opts("Git branches"))
map('n', "<leader>gd", "<cmd>lua require('snacks').picker.git_diff()<cr>", opts("Git differences"))
map('n', "<leader>gg", "<cmd>lua require('snacks').lazygit()<cr>", opts("Lazygit"))
map('n', "<leader>gl", "<cmd>lua require('snacks').lazygit.log()<cr>", opts("Lazygit logs"))
map('n', "<leader>gs", "<cmd>lua require('snacks').picker.git_status()<cr>", opts("Git status"))

-- ===========================================================================
-- NOTE: Navigation
-- ===========================================================================

-- NOTE: Window navigation
map('n', "<C-d>", "<C-d>zz", { desc = "Go down half page and center" })
map('n', "<C-u>", "<C-u>zz", { desc = "Go up half pase and center" })
map('n', "<C-h>", "<C-w>h", { desc = "Go to left window" })
map('n', "<C-j>", "<C-w>j", opts("Go to lower window"))
map('n', "<C-k>", "<C-w>k", opts("Go to upper window"))
map('n', "<C-l>", "<C-w>l", opts("Go to risht window"))
map('t', "<C-h>", [[<C-\><C-n><C-w>h]], opts("Go to left terminal"))
map('t', "<C-j>", [[<C-\><C-n><C-w>j]], opts("Go to lower terminal"))
map('t', "<C-k>", [[<C-\><C-n><C-w>k]], opts("Go to upper terminal"))
map('t', "<C-l>", [[<C-\><C-n><C-w>l]], opts("Go to right terminal"))

-- NOTE: New file
map('n', "<leader>nf", "<cmd>enew<cr>", opts("New file"))

-- NOTE: Dashboard
map('n', "<leader>nd", "<cmd>lua require('snacks').dashboard()<cr>", opts("Snacks dashboard"))

-- NOTE: Explorer
map('n', "<leader>ne", "<cmd>lua require('snacks').picker.explorer()<cr>", opts("Snacks file explorer"))

-- NOTE: Yazi
map({ 'n', 'v' }, "<leader>ny", "<cmd>Yazi cwd<cr>", opts("Open Yazi in current working directory"))

-- NOTE: Terminal
local function toggle_snacks_term(pos)
  require("snacks").terminal.open(nil, { win = { position = pos } })
end

map({ 'n', 't' }, "<leader>ntj", function() toggle_snacks_term("bottom") end, opts("Toggle terminal at bottom"))
map({ 'n', 't' }, "<leader>ntk", function() toggle_snacks_term("top") end, opts("Toggle terminal at top"))
map({ 'n', 't' }, "<leader>nth", function() toggle_snacks_term("left") end, opts("Toggle terminal at left"))
map({ 'n', 't' }, "<leader>ntl", function() toggle_snacks_term("right") end, opts("Toggle terminal at right"))

-- ===========================================================================
-- NOTE: Picker
-- ===========================================================================

-- NOTE: Find
map('n', "<leader>fa", "<cmd>lua require('snacks').picker.autocmds({ layout = 'vertical' })<cr>", opts("Find autocmds"))
map('n', "<leader>fb", "<cmd>lua require('snacks').picker.buffers({ focus = 'list' })<cr>", opts("Find buffers"))
map('n', "<leader>fB", "<cmd>lua require('snacks').picker.grep_buffers()<cr>", opts("Grep open buffers"))
map('n', "<leader>fc", "<cmd>lua require('snacks').picker.files({ cwd = vim.fn.stdpath('config') })<cr>",
  opts("Find config files"))
map('n', "<leader>fC", "<cmd>lua require('snacks').picker.commands({ layout = 'select' })<cr>", opts("Find commands"))
map('n', "<leader>ff", "<cmd>lua require('snacks').picker.files({ focus = 'input' })<cr>", opts("Find files"))
map('n', "<leader>fg", "<cmd>lua require('snacks').picker.grep_word({ focus = 'list', layout = 'vertical' })<cr>",
  opts("Grep selection"))
map('n', "<leader>fG", "<cmd>lua require('snacks').picker.grep()<cr>", opts("Live grep"))
map('n', "<leader>fh", "<cmd>lua require('snacks').picker.highlights({ layout = 'dropdown', focus = 'list' })<cr>",
  opts("Find highlights"))
map('n', "<leader>fH", "<cmd>lua require('snacks').picker.help({ layout = 'vertical' })<cr>", opts("Find help pages"))
map('n', "<leader>fi", "<cmd>lua require('snacks').picker.icons()<cr>", opts("Find icons"))
map('n', "<leader>fk", "<cmd>lua require('snacks').picker.keymaps({ layout = 'vertical' })<cr>", opts("Find keymaps"))
map('n', "<leader>fm", "<cmd>lua require('snacks').picker.marks({ layout = 'vertical' })<cr>", opts("Find marks"))
map('n', "<leader>fM", "<cmd>lua require('snacks').picker.man()<cr>", opts("Find man pages"))
map('n', "<leader>fp", "<cmd>lua require('snacks').picker.projects({ layout = 'select', focus = 'list' })<cr>",
  opts("Find projects"))
map('n', "<leader>fr", "<cmd>lua require('snacks').picker.recent({ focus = 'list' })<cr>", opts("Find recent files"))
map('n', "<leader>fs", "<cmd>lua require('snacks').picker.snippets({ layout = 'vertical' })<cr>", opts("Find snippets"))
map('n', "<leader>fS", "<cmd>lua require('snacks').picker.colorschemes({ layout = 'select', focus = 'input' })<cr>",
  opts("Find colorschemes"))
map('n', "<leader>ft", "<cmd>lua require('snacks').picker.todo_comments()<cr>", opts("Find Todo comments"))
map('n', "<leader>fT", "<cmd>lua require('snacks').picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })<cr>",
  opts("Find Todo/Fix/Fixme"))

-- NOTE: Search
map('n', '<leader>s"', "<cmd>lua require('snacks').picker.registers({ layout = 'dropdown', focus = 'list' })<cr>",
  opts("Search registers"))
map('n', "<leader>s:", "<cmd>lua require('snacks').picker.command_history({ focus = 'list' })<cr>",
  opts("Search command history"))
map('n', "<leader>s/", "<cmd>lua require('snacks').picker.search_history({ focus = 'list' })<cr>", opts("Search notification history"))
map('n', "<leader>sn", "<cmd>lua require('snacks').notifier.show_history()<cr>", opts("Search notifications history"))
map('n', "<leader>su", "<cmd>lua require('snacks').picker.undo({ layout = 'vertical' })<cr>", opts("Search undo history"))
map('n', "<leader>sq", "<cmd>lua require('snacks').picker.qflist()<cr>", opts("Search quickfix list"))
map('n', "<leader>sx", "<cmd>noh<cr>", opts("Search clear"))

-- ===========================================================================
-- NOTE: Words & LSP
-- ===========================================================================
map('n', "<leader>ld", "<cmd>lua require('snacks').picker.diagnostics()<cr>", opts("Find LSP diagnostics"))
map('n', "<leader>lD", "<cmd>lua require('snacks').picker.diagnostics_buffer()<cr>", opts("Find LSP buffer diagnostics"))
map('n', "<leader>ll", "<cmd>lua require('snacks').words.jump(vim.v.count1)<cr>", opts("Next LSP reference"))
map('n', "<leader>lL", "<cmd>lua require('snacks').words.jump(-vim.v.count1)<cr>", opts("Previous LSP reference"))
map('n', "<leader>lR", "<cmd>lua require('snacks').picker.references()<cr>", opts("Find LSP references"))
map('n', "<leader>ls", "<cmd>lua require('snacks').picker.lsp_symbols({ layout = 'vertical' })<cr>",
  opts("Find LSP symbols"))
map('n', "<leader>lS", "<cmd>lua require('snacks').picker.lsp_workspace_symbols({ layout = 'vertical' })<cr>",
  opts("Find LSP workspace symbols"))
map('n', "<leader>lcp", "<cmd>CccPick<cr>", opts("Toggles color picker"))
map('n', "<leader>lCd", "<cmd>RainbowDelim<cr>", opts("Rainbow CSV delim with character under cursor"))
map('n', "<leader>lCa", "<cmd>RainbowAlign<cr>", opts("Rainbow CSV align"))
map('n', "<leader>lCs", "<cmd>RainbowShrink<cr>", opts("Rainbow CSV shrink"))
map('n', "<leader>lK", "<cmd>lua require('codedocs').insert_docs()<cr>", opts("Insert code docs"))

-- ===========================================================================
-- NOTE: Folds
-- ===========================================================================

-- HACK: Function to fold all headings of a specific level
local function fold_headings_of_level(level)
  -- Move to the top of the file
  vim.cmd("normal! gg")
  -- Get the total number of lines
  local total_lines = vim.fn.line("$")
  for line = 1, total_lines do
    -- Get the content of the current line
    local line_content = vim.fn.getline(line)
    -- "^" -> Ensures the match is at the start of the line
    -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
    -- "%s" -> Matches any whitespace character after the "#" characters
    -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
    if line_content:match("^" .. string.rep("#", level) .. "%s") then
      -- Move the cursor to the current line
      vim.fn.cursor(line, 1)
      -- Fold the heading if it matches the level
      if vim.fn.foldclosed(line) == -1 then
        vim.cmd("normal! za")
      end
    end
  end
end

-- HACK: Fold markdown headings
local function fold_markdown_headings(levels)
  -- I save the view to know where to jump back after folding
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    fold_headings_of_level(level)
  end
  vim.cmd("nohlsearch")
  -- Restore the view to jump to where I was
  vim.fn.winrestview(saved_view)
end

-- HACK: Use <CR> to fold in normal mode
map('n', "<CR>", function()
  -- Get current line number
  local line = vim.fn.line(".")

  -- Get fold level
  local foldlevel = vim.fn.foldlevel(line)
  if foldlevel == 0 then
    vim.notify("No fold found", vim.log.levels.INFO)
  else
    vim.cmd("normal! za")
    vim.cmd("normal! zz")
  end
end, opts("Toggle fold"))

-- HACK: Fold markdown headings in Neovim with a keymap
-- Keymap for folding markdown headings of level 1 or above
map('n', "zj", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfj", function()
  -- Reloads the file to refresh folds, otheriise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, opts("Fold all headings level 1 or above"))

-- HACK: Fold markdown headings in Neovim with a keymap
-- Keymap for folding markdown headings of level 2 or above
map('n', "zk", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, opts("Fold all headings level 2 or above"))

-- HACK: Fold markdown headings in Neovim with a keymap
-- Keymap for folding markdown headings of level 3 or above
map('n', "zl", function()
  -- Saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, opts("Fold all headings level 3 or above"))
