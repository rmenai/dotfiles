{ config, lib, ... }:
let
  cfg = config.features.core.persistence;
  persistFolder = config.spec.persistFolder;
in
{
  options.features.core.persistence = {
    enable = lib.mkEnableOption "Ephemeral BTRFS root with persistence";
  };

  config = lib.mkMerge [
    {
      environment.persistence.${persistFolder} = {
        enable = cfg.enable; # This disables persistence by default
        hideMounts = true;
      };
    }
    (lib.mkIf cfg.enable {
      fileSystems.${persistFolder}.neededForBoot = true;
      programs.fuse.userAllowOther = true;

      boot.initrd.systemd.services.btrfs-rollback = {
        description = "Rollback BTRFS root (skip on hibernation resume)";
        wantedBy = [ "initrd.target" ];
        after = [
          "initrd-root-device.target"
          "local-fs-pre.target"
        ];
        before = [
          "sysroot.mount"
          "create-needed-for-boot-dirs.service"
        ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir /btrfs_tmp
          mount /dev/root_vg/root /btrfs_tmp
          if [[ -e /btrfs_tmp/root ]]; then
              mkdir -p /btrfs_tmp/old_roots
              timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
              mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
          fi

          delete_subvolume_recursively() {
              IFS=$'\n'
              for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                  delete_subvolume_recursively "/btrfs_tmp/$i"
              done
              btrfs subvolume delete "$1"
          }

          for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
              delete_subvolume_recursively "$i"
          done

          btrfs subvolume create /btrfs_tmp/root
          umount /btrfs_tmp
        '';
      };
    })
  ];
}
