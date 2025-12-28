{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.features.apps.browsers.vivaldi;
in
{
  options.features.apps.browsers.vivaldi = {
    enable = lib.mkEnableOption "Vivaldi browser";
  };

  config = lib.mkIf cfg.enable {
    programs.vivaldi.enable = true;

    sops.secrets."data" = {
      sopsFile = "${builtins.toString inputs.secrets}/files/surfingkeys.js";
      path = "/home/${config.spec.user}/.config/vivaldi/surfingkeys.js";
    };

    catppuccin.vivaldi.enable = true;
  };
}
