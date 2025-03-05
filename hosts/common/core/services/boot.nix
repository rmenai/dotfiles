{
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 32;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd.systemd.enable = true;
  boot.initrd.services.lvm.enable = true;
}
