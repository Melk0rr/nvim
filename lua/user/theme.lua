-- HACK: Handling theme based on hyde
-- INFO: Function to check if the file exists
local function check_config(file_path)
  local f = io.open(file_path, "rb")
  if f then
    f:close()
  end
  return f ~= nil
end

-- INFO: Function to extract hyde theme
local function get_hyde_theme(file_path)
  if not check_config(file_path) then
    return nil
  end

  for line in io.lines(file_path) do
    local theme = line:match('hydeTheme="([^"]+)"')
    if theme then
      return theme
    end
  end
  return nil
end

-- INFO: Function to change colorscheme based on hyde theme
local function set_colorscheme(file_path)
  local theme = get_hyde_theme(file_path)
  if theme then
    -- NOTE: Autumn Leaves
    if theme == "Autumn Leaves" then
      vim.cmd [[colorscheme melange]]

      -- NOTE: Barad Dur
    elseif theme == "Barad Dur" then
      vim.cmd [[colorscheme darkrose]]

      -- NOTE: Catppuccin Latte
    elseif theme == "Catppuccin Latte" then
      vim.cmd [[colorscheme kanagawa-lotus]]

      -- NOTE: Catppuccin Mocha
    elseif theme == "Catppuccin Mocha" then
      vim.cmd [[colorscheme catppuccin-mocha]]

      -- NOTE: Cosmic Blue
    elseif theme == "Cosmic Blue" then
      vim.cmd [[colorscheme iceberg]]

      -- NOTE: Decay Green
    elseif theme == "Decay Green" then
      vim.cmd [[colorscheme everblush]]

      -- NOTE: Edge Runner
    elseif theme == "Edge Runner" then
      vim.cmd [[colorscheme lavender]]

      -- NOTE: Graphite Mono
    elseif theme == "Graphite Mono" then
      vim.cmd [[colorscheme lackluster]]

      -- NOTE: Gruvbox Retro
    elseif theme == "Gruvbox Retro" then
      vim.cmd [[colorscheme gruvbox]]

      -- NOTE: Nordic Blue
    elseif theme == "Nordic Blue" then
      vim.cmd [[colorscheme nord]]

      -- NOTE: Rosé Pine
    elseif theme == "Rosé Pine" then
      vim.cmd [[colorscheme rose-pine]]

      -- NOTE: Rust Sand
    elseif theme == "Rust Sand" then
      vim.cmd [[colorscheme melange]]

      -- NOTE: Sci-Fi
    elseif theme == "Sci-Fi" then
      vim.cmd [[colorscheme lavender]]

      -- NOTE: Silent Shrine
    elseif theme == "Silent Shrine" then
      vim.cmd [[colorscheme evergarden]]

      -- NOTE: Synth Wave
    elseif theme == "Synth Wave" then
      vim.cmd [[colorscheme lavender]]

      -- NOTE: Terra Nova
    elseif theme == "Terra Nova" then
      vim.cmd [[colorscheme kanagawa-wave]]

      -- NOTE: Tokyo Night
    elseif theme == "Tokyo Night" then
      vim.cmd [[colorscheme tokyonight-night]]
    end
  else
    print(theme)
    print("Failed to read hyde conf")
  end
end

-- NOTE: Setting theme
local hyde_conf = os.getenv("HOME") .. "/.config/hyde/hyde.conf"
set_colorscheme(hyde_conf)

