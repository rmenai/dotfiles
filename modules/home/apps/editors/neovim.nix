{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.editors.neovim;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  options.features.apps.editors.neovim = {
    enable = lib.mkEnableOption "Neovim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      vimgolf
      lazygit
      curl
      fzf
    ];

    xdg.configFile."nvim".source = mkLink ./nvim;

    catppuccin = {
      nvim.enable = true;
      lazygit.enable = true;
    };
  };
}
