{ modulesPath, lib, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "/dev/sda";
      };
      timeout = lib.mkDefault 3;
    };

    initrd.systemd.enable = true;
  };

  services = {
    qemuGuest.enable = true;
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };
}
