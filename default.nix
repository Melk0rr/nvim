{ pkgs, ... }:
# Neovim configuration
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraLuaConfig = ''
      dofile(os.getenv 'HOME' .. '/nixos-config/modules/home/nvim/init.lua')
    '';
    # extraPackages = with pkgs; [
    #   # Language server packages (executables)
    #   bash-language-server                  # Bash
    #   ccls                                  # C/C++
    #   fish-lsp                              # Fish
    #   nil                                   # Nix
    #   pyright                               # Python
    #   rust-analyzer                         # Rust
    #   sumneko-lua-language-server           # Lua
    # ];
  };
}
