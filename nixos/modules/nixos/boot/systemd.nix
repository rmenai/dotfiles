{ config, lib, ... }: {
  options.features.boot.systemd = {
    enable = lib.mkEnableOption "systemd-boot bootloader";
  };

  config = lib.mkIf config.features.boot.systemd.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = config.features.boot.configurationLimit;
      };

      efi.canTouchEfiVariables = true;
      timeout = config.features.boot.timeout;
    };
  };
}
