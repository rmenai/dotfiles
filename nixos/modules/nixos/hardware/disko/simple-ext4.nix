{ config, lib, ... }: {
  config = lib.mkIf (config.features.hardware.disko.profile == "simple-ext4") {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = config.features.hardware.disko.device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
