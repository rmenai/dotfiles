{ config, lib, ... }: {
  options.features.hardware.disko = {
    profile = lib.mkOption {
      type = lib.types.enum [ "none" "btrfs-luks" ];
      default = "none";
      description = "Disk layout profile to use";
    };

    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/nvme0n1";
      description = "Primary disk device";
    };

    swapSize = lib.mkOption {
      type = lib.types.str;
      default = "32G";
      description = "Swap file size";
    };
  };

  config = lib.mkIf (config.features.hardware.disko.profile == "btrfs-luks") {
    boot.initrd.services.lvm.enable = true;

    disko.devices = {
      disk.main = {
        type = "disk";
        device = config.features.hardware.disko.device;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };

            esp = {
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" "umask=0077" ];
              };
            };

            luks = {
              name = "luks";
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = { allowDiscards = true; };

                content = {
                  type = "lvm_pv";
                  vg = "root_vg";
                };
              };
            };
          };
        };
      };

      lvm_vg = {
        root_vg = {
          type = "lvm_vg";
          lvs = {
            root = {
              size = "100%FREE";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];

                subvolumes = {
                  "/root" = { mountpoint = "/"; };

                  "/persist" = {
                    mountOptions = [ "subvol=persist" "noatime" ];
                    mountpoint = "/persist";
                  };

                  "/nix" = {
                    mountOptions = [ "subvol=nix" "noatime" ];
                    mountpoint = "/nix";
                  };

                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size =
                      config.features.hardware.disko.swapSize;
                  };
                };
              };
            };
          };
        };
      };
    };

    swapDevices = [{ device = "/.swapvol/swapfile"; }];
  };
}
