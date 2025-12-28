{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.shells.nushell;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  options.features.apps.shells.nushell = {
    enable = lib.mkEnableOption "Nushell shell";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nushell ];

    programs = {
      starship.enable = true;
      carapace.enable = true;
    };

    xdg.configFile."nushell".source = mkLink ./nushell;
    home.file.".profile".source = mkLink ./shell/profile;
  };
}
