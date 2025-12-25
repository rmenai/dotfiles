{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.uutils;
in
{
  options.features.apps.uutils = {
    enable = lib.mkEnableOption "Rust-based coreutils (uutils) as system defaults";
  };

  config = lib.mkIf cfg.enable {
    # hiPrio ensures these binaries take precedence over GNU coreutils
    environment.systemPackages = [ (lib.hiPrio pkgs.uutils-coreutils-noprefix) ];
  };
}
