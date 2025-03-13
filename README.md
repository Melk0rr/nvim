<div align="center">
    <img src="./neovim.svg" />
</div>

# My neovim config
## Plugins I use
### UI
require("user.plugins.bufferline"),
require("user.plugins.ccc"),
require("user.plugins.illuminate"),
require("user.plugins.lualine"),
require("user.plugins.noice"),

### QoL
require("user.plugins.snacks"),
require("user.plugins.todo-comments"),
require("user.plugins.whichkey"),

### LSP / Linting / Completion / Language support
require("user.plugins.treesitter"),
require("user.plugins.blink"),
require("user.plugins.crates"),
require("user.plugins.inlay-hint"),
require("user.plugins.lspconfig"),
require("user.plugins.markdown"),
require("user.plugins.mason"),
require("user.plugins.mini"),
require("user.plugins.rainbowcsv"),
require("user.plugins.rustaceanvim"),

### Debug
require("user.plugins.dap"),

## Colorschemes
I can use many different colorschemes depending on which distro I'm on

### Arch Linux
As I use dynamic themes on my [Arch Linux / Hyprland](https://github.com/Melk0rr/arch) setup, I also use a lot of neovim colorshemes to match my wallpapers and dotfiles
My favorite ones are
- [Gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
- [Tokyonight](https://github.com/folke/tokyonight.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)

But I also use
- [Darkrose](https://github.com/water-sucks/darkrose.nvim)
- [Iceberg](https://github.com/oahlen/iceberg.nvim)
- [Kanagawa](https://github.com/rebelot/kanagawa.nvim)
- [Lavender](https://codeberg.org/jthvai/lavender.nvim)
- [Melange](https://github.com/savq/melange-nvim)
- [Nord](https://github.com/shaunsingh/nord.nvim)
- [Rose-pine](https://github.com/rose-pine/neovim)
- [Everblush](https://github.com/Everblush/everblush.nvim)
- [Evergarden](https://github.com/comfysage/evergarden)


### OpenSUSE
While using OpenSUSE Tumbleweed on my laptop, I mainly use [Gruvbox](https://github.com/ellisonleao/gruvbox.nvim) as I find it matches the most the OpenSUSE aesthetic

### NixOS
While on my tablet, [Catppuccin](https://github.com/catppuccin/nvim) for the whole system

### Debian
Finally, while on Debian, I use either
- [Rose-pine](https://github.com/rose-pine/neovim)
- [Darkrose](https://github.com/water-sucks/darkrose.nvim)
