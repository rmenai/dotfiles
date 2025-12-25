{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.bat;
in
{
  options.features.apps.tools.bat = {
    enable = lib.mkEnableOption "Bat syntax highlighter";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      extraPackages = builtins.attrValues {
        inherit (pkgs.bat-extras) batgrep batdiff batman;
      };
    };

    home.activation.batCacheRebuild = {
      after = [ "linkGeneration" ];
      before = [ ];
      data = ''
        ${pkgs.bat}/bin/bat cache --build
      '';
    };

    features.core.dotfiles.links.bat = "bat";
  };
}
