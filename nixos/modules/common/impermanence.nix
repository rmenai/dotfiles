{ lib, ... }:
{
  options.features.impermanence = {
    enable = lib.mkEnableOption "impermanence support";

    persistFolder = lib.mkOption {
      type = lib.types.str;
      description = "The folder to persist data if impermanence is enabled";
      default = "/persist";
    };
  };
}
