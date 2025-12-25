{ config, lib, ... }:
let
  cfg = config.features.hardware.disko;
in
{
  config = lib.mkIf (cfg.profile == "btrfs-lvm") {
    boot.initrd.services.lvm.enable = true;
    boot.supportedFilesystems = [ "btrfs" ];

    disko.devices = {
      disk.main = {
        type = "disk";
        device = cfg.device;
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
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };

            lvm = {
              name = "lvm";
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "root_vg";
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
                  "/root" = {
                    mountpoint = "/";
                  };

                  "/nix" = {
                    mountOptions = [
                      "subvol=nix"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };

                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = cfg.swapSize;
                  };
                };
              };
            };
          };
        };
      };
    };

    swapDevices = [ { device = "/.swapvol/swapfile"; } ];
  };
}
