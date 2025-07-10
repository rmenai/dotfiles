{
  config,
  lib,
  ...
}: {
  options.features.persist = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.features.impermanence.enable;
      description = "persistence support";
    };

    directories = lib.mkOption {
      type = lib.types.attrsOf lib.types.bool;
      default = {};
      description = ''
        Mapping of directories to a boolean.
      '';
    };

    files = lib.mkOption {
      type = lib.types.attrsOf lib.types.bool;
      default = {};
      description = ''
        Mapping of files to a boolean.
      '';
    };
  };

  # config = lib.mkIf config.features.persist.enable {
  #   features.impermanence.enable = true;
  # };
}
