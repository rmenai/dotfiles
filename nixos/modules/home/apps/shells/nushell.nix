{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.shells.nushell;
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

    features.core.dotfiles.links = {
      nushell = "nushell";
    };

    features.core.dotfiles.homeLinks.".profile" = "shell/.profile";
  };
}
