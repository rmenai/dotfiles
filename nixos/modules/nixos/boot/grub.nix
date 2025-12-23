{ config, lib, ... }:
{
  options.features.boot.grub = {
    enable = lib.mkEnableOption "GRUB bootloader";
  };

  config = lib.mkIf config.features.boot.grub.enable {
    boot.loader = {
      grub = {
        enable = true;
        configurationLimit = config.features.boot.configurationLimit;
        efiSupport = true;
        efiInstallAsRemovable = true;
      };

      efi.canTouchEfiVariables = false;
      timeout = config.features.boot.timeout;
    };
  };
}
