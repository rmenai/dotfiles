{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
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

          luks = {
            name = "luks";
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings = {
                allowDiscards = true;
              };

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
              extraArgs = ["-f"];

              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                };

                "/persist" = {
                  mountOptions = [
                    "subvol=persist"
                    "noatime"
                  ];
                  mountpoint = "/persist";
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
                  swap.swapfile.size = "32G";
                };
              };
            };
          };
        };
      };
    };
  };

  swapDevices = [{device = "/.swapvol/swapfile";}];

  boot.resumeDevice = "/dev/mapper/root_vg-root";
  boot.kernelParams = ["resume_offset=533760"];
}
