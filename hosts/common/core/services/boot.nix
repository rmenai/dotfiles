{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd.systemd.enable = true;
  boot.initrd.services.lvm.enable = true;
}
