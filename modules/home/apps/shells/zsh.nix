{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.shells.zsh;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  options.features.apps.shells.zsh = {
    enable = lib.mkEnableOption "Zsh shell";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ zsh ];

    home.file = {
      ".zfunc".source = mkLink ./shell/zfunc;
      ".zshrc".source = mkLink ./shell/zshrc;
      ".p10k.zsh".source = mkLink ./shell/p10k.zsh;
      ".profile".source = mkLink ./shell/profile;
    };
  };
}
