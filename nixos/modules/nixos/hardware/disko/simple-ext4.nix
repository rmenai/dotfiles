{ config, lib, ... }: {
  config = lib.mkIf (config.features.hardware.disko.profile == "simple-ext4") {
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = config.features.hardware.disko.device;
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "1M";
                type = "EF02";
                priority = 1;
              };
              esp = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "defaults" "umask=0077" ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                  mountOptions = [ "noatime" "nodiratime" "discard" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
