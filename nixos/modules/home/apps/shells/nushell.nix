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
      carapace.enable = true;
      starship.enable = true;
    };

    features.core.dotfiles.links = {
      nushell = "nushell";
      "starship.toml " = "starship.toml";
    };

    features.core.dotfiles.homeLinks.".profile" = "shell/.profile";
  };
}
