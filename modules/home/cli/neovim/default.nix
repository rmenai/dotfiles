{ config, pkgs, ... }:
let
  mkLink = config.dotfiles.mkLink;
in
{
  home = {
    shellAliases = {
      v = "nvim";
      vimdiff = "nvim -d";
      g = "nvim +Neogit";
    };

    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };

  home.packages = with pkgs; [
    neovim-unwrapped
    lazygit
  ];

  xdg.configFile."nvim".source = mkLink ./nvim;

  catppuccin = {
    nvim.enable = true;
    lazygit.enable = true;
  };
}
