{ config, lib, ... }: {
  options.features.apps.index = {
    enable = lib.mkEnableOption "Nix-index database";
  };

  config = lib.mkIf config.features.apps.index.enable {
    programs.nix-index-database.comma.enable = true;
  };
}
