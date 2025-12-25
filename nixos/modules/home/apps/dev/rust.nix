{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.apps.dev.rust;
in
{
  options.features.apps.dev.rust = {
    enable = lib.mkEnableOption "Rust Toolchain";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.rustup ];

    features.core.dotfiles.links.bacon = "bacon";
  };
}
