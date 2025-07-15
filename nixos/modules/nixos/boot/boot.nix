{ config, lib, ... }: {
  options.features.boot = {
    configurationLimit = lib.mkOption {
      type = lib.types.int;
      default = 16;
      description = "Maximum number of configurations to keep";
    };

    timeout = lib.mkOption {
      type = lib.types.int;
      default = 3;
      description = "Boot menu timeout in seconds";
    };

    initrd = {
      enable = lib.mkEnableOption "systemd in initrd" // { default = true; };
    };
  };

  config = { boot.initrd.systemd.enable = config.features.boot.initrd.enable; };
}
