local map = vim.keymap.set
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- NOTE: Common
map('', 'Y', 'y$', opts("Yank whole line"))
map('n', "<leader;", "mqA;<esc>`q", opts("Semicolon at end of line"))
map('n', "<leader>h", "<cmd>noh<cr>", opts("No search highlight"))
map('n', "<leader>qq", "<cmd>wqa!<cr>", opts("Save and quit"))
map('n', "<C-a>", "goVG", opts("Select all"))
map('n', "<leader>nf", "<cmd>enew<cr>", opts("New file"))

-- NOTE: Press jk fast to exit insert mode
map('i', "jk", "<ESC>", opts("jk to exit insert mode"))
map('i', "kj", "<ESC>", opts("kj to exit insert mode"))

-- NOTE: Window navigation
map('n', "<C-h>", "<C-w>h", opts("Go to left window"))
map('n', "<C-j>", "<C-w>j", opts("Go to lower window"))
map('n', "<C-k>", "<C-w>k", opts("Go to upper window"))
map('n', "<C-l>", "<C-w>l", opts("Go to right window"))
map('t', "<C-h>", [[<C-\><C-n><C-w>h]], opts("Go to left terminal"))
map('t', "<C-j>", [[<C-\><C-n><C-w>j]], opts("Go to lower terminal"))
map('t', "<C-k>", [[<C-\><C-n><C-w>k]], opts("Go to upper terminal"))
map('t', "<C-l>", [[<C-\><C-n><C-w>l]], opts("Go to right terminal"))

-- NOTE: Buffer navigation
map('n', "<Tab>", "<cmd>bnext<cr>", opts("Next buffer"))
map('n', "<S-Tab>", "<cmd>bprevious<cr>", opts("Previous buffer"))
map('n', "<leader>bd", "<cmd>lua require('snacks').bufdelete()<cr>", opts("Delete buffer"))
map('n', "<leader>bo", "<cmd>lua require('snacks').bufdelete.other()<cr>", opts("Delete other buffer"))

-- NOTE: Stay in indent mode
map('v', '<', "<gv", opts("Unindent"))
map('v', '>', ">gv", opts("Indent"))

-- NOTE: Move lines
map('n', "<A-j>", ":m .+1<cr>==", opts("Move line down"))
map('n', "<A-k>", ":m .-2<cr>==", opts("Move line up"))
map('v', "<A-j>", ":m '>+1<cr>gv=gv", opts("Move selection down"))
map('v', "<A-k>", ":m '<-2<cr>gv=gv", opts("Move selection up"))

-- NOTE: Debugging
map('n', "<leader>dc", "<cmd>lua require('dap').continue()<cr>", opts("Debugger continue"))
map('n', "<leader>dj", "<cmd>lua require('dap').step_over()<cr>", opts("Debugger step over"))
map('n', "<leader>dk", "<cmd>lua require('dap').step_out()<cr>", opts("Debugger step out"))
map('n', "<leader>dl", "<cmd>lua require('dap').step_into()<cr>", opts("Debugger step into"))
map('n', "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts("Debugger toggle breakpoint"))
map('n', "<leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<cr>", opts("Debugger run rust tests"))
map('n', "<leader>dx", "<cmd>lua require('dap').terminate()<cr><cmd>lua require('dapui').close()<cr>", opts("Debugger terminate"))

-- NOTE: Git
map('n', "<leader>gb", "<cmd>lua require('snacks').git.blame_line()<cr>", opts("Git blame Line"))
map('n', "<leader>gB", "<cmd>lua require('snacks').picker.git_branches()<cr>", opts("Git branches"))
map('n', "<leader>gd", "<cmd>lua require('snacks').picker.git_diff()<cr>", opts("Git differences"))
map('n', "<leader>gg", "<cmd>lua require('snacks').lazygit()<cr>", opts("Lazygit"))
map('n', "<leader>gl", "<cmd>lua require('snacks').lazygit.log()<cr>", opts("Lazygit logs"))
map('n', "<leader>gs", "<cmd>lua require('snacks').picker.git_status()<cr>", opts("Git status"))

-- NOTE: Dashboard
map('n', "<leader>a", "<cmd>lua require('snacks').dashboard()<cr>", opts("Snacks dashboard"))

-- NOTE: Explorer
map('n', "<leader>e", "<cmd>lua require('snacks').picker.explorer()<cr>", opts("Snacks file explorer"))

-- NOTE: Picker find
map('n', "<leader>fa", "<cmd>lua require('snacks').picker.autocmds()<cr>", opts("Find autocmds"))
map('n', "<leader>fb", "<cmd>lua require('snacks').picker.buffers()<cr>", opts("Find buffers"))
map('n', "<leader>fB", "<cmd>lua require('snacks').picker.grep_buffers()<cr>", opts("Grep open buffers"))
map('n', "<leader>fc", "<cmd>lua require('snacks').picker.files()<cr>", opts("Find config files"))
map('n', "<leader>fC", "<cmd>lua require('snacks').picker.commands()<cr>", opts("Find commands"))
map('n', "<leader>ff", "<cmd>lua require('snacks').picker.files()<cr>", opts("Find files"))
map('n', "<leader>fg", "<cmd>lua require('snacks').picker.grep_word()<cr>", opts("Grep selection"))
map('n', "<leader>fG", "<cmd>lua require('snacks').picker.grep({ focus = 'input' })<cr>", opts("Live grep"))
map('n', "<leader>fh", "<cmd>lua require('snacks').picker.highlights()<cr>", opts("Find highlights"))
map('n', "<leader>fH", "<cmd>lua require('snacks').picker.help()<cr>", opts("Find help pages"))
map('n', "<leader>fi", "<cmd>lua require('snacks').picker.icons()<cr>", opts("Find icons"))
map('n', "<leader>fk", "<cmd>lua require('snacks').picker.keymaps({ layout = 'vertical' })<cr>", opts("Find keymaps"))
map('n', "<leader>fM", "<cmd>lua require('snacks').picker.man()<cr>", opts("Find man pages"))
map('n', "<leader>fp", "<cmd>lua require('snacks').picker.projects()<cr>", opts("Find projects"))
map('n', "<leader>fr", "<cmd>lua require('snacks').picker.recent()<cr>", opts("Find recent files"))
map('n', "<leader>fS", "<cmd>lua require('snacks').picker.colorschemes({ layout = 'select' })<cr>", opts("Find colorschemes"))
map('n', "<leader>ft", "<cmd>lua require('snacks').picker.todo_comments()<cr>", opts("Find Todo comments"))
map('n', "<leader>fT", "<cmd>lua require('snacks').picker.todo_comments({ 'TODO', 'FIX', 'FIXME' })<cr>", opts("Find Todo/Fix/Fixme"))

-- NOTE: Picker search
map('n', '<leader>s"', "<cmd>lua require('snacks').picker.registers()<cr>", opts("Search registers"))
map('n', "<leader>s:", "<cmd>lua require('snacks').picker.command_history()<cr>", opts("Search command history"))
map('n', "<leader>s/", "<cmd>lua require('snacks').picker.search_history()<cr>", opts("Search history"))
map('n', "<leader>sn", "<cmd>lua require('snacks').notifier.show_history()<cr>", opts("Search history"))
map('n', "<leader>su", "<cmd>lua require('snacks').picker.undo({ layout = 'vertical' })<cr>", opts("Search undo history"))

-- NOTE: Terminal
map({ 'n', 't' }, "<leader>tt", "<cmd>lua require('snacks').terminal()<cr>", opts("Toggle terminal"))

-- NOTE: Words & LSP
map('n', "<leader>ld", "<cmd>lua require('snacks').picker.diagnostics()<cr>", opts("Find LSP diagnostics"))
map('n', "<leader>lD", "<cmd>lua require('snacks').picker.diagnostics_buffer()<cr>", opts("Find LSP buffer diagnostics"))
map('n', "<leader>ll", "<cmd>lua require('snacks').words.jump(vim.v.count1)<cr>", opts("Next LSP reference"))
map('n', "<leader>lL", "<cmd>lua require('snacks').words.jump(-vim.v.count1)<cr>", opts("Previous LSP reference"))
map('n', "<leader>lR", "<cmd>lua require('snacks').picker.references()<cr>", opts("Find LSP references"))
map('n', "<leader>ls", "<cmd>lua require('snacks').picker.lsp_symbols({ layout = 'vertical' })<cr>", opts("Find LSP symbols"))
map('n', "<leader>lS", "<cmd>lua require('snacks').picker.lsp_workspace_symbols({ layout = 'vertical' })<cr>", opts("Find LSP workspace symbols"))
map('n', "<leader>lcp", "<cmd>CccPick<cr>", opts("Toggles color picker"))
map('n', "<leader>lCd", "<cmd>RainbowDelim<cr>", opts("Rainbow CSV delim with character under cursor"))
map('n', "<leader>lCa", "<cmd>RainbowAlign<cr>", opts("Rainbow CSV align"))
map('n', "<leader>lCs", "<cmd>RainbowShrink<cr>", opts("Rainbow CSV shrink"))

-- NOTE: Folds
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
map('n', "<CR>", function ()
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
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, opts("Fold all headings level 3 or above"))

