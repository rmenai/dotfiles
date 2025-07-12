{ config, lib, ... }: {
  options.features.boot.grub = {
    enable = lib.mkEnableOption "GRUB bootloader";
  };

  config = {
    boot.loader = {
      grub = {
        enable = config.features.boot.grub.enable;
        configurationLimit = config.features.boot.configurationLimit;
        efiSupport = true;
      };

      efi.canTouchEfiVariables = true;
      timeout = config.features.boot.timeout;
    };
  };
}
