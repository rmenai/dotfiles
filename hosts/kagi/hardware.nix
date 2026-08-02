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

  # Kernel Hardening
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.sysrq" = 0;
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;
    "dev.tty.ldisc_autoload" = 0;
  };

  security.auditd.enable = true;
}
