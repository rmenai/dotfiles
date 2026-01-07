{ config, lib, ... }:
let
  cfg = config.features.core.persistence;
in
{
  options.features.core.persistence = {
    enable = lib.mkEnableOption "system persistence and rollback";

    folder = lib.mkOption {
      type = lib.types.str;
      default = "/persist";
      description = "The permanent volume mount point.";
    };

    directories = lib.mkOption {
      type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
      default = [ ];
      description = "System directories to persist (e.g. /var/log).";
    };

    files = lib.mkOption {
      type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
      default = [ ];
      description = "System files to persist (e.g. /etc/machine-id).";
    };
  };

  config = lib.mkIf cfg.enable {
    fileSystems."${cfg.folder}".neededForBoot = true;

    environment.persistence."${cfg.folder}" = {
      hideMounts = true;
      directories = cfg.directories;
      files = cfg.files;
    };

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
  };
}
