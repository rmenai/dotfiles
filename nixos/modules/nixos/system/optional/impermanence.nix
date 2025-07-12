{ config, lib, ... }: {
  config = lib.mkIf config.features.impermanence.enable {
    boot.initrd.systemd.services.btrfs-rollback = {
      description = "Rollback BTRFS root (skip on hibernation resume)";
      wantedBy = [ "initrd.target" ];
      after = [ "initrd-root-device.target" "local-fs-pre.target" ];
      before = [ "sysroot.mount" "create-needed-for-boot-dirs.service" ];
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

    fileSystems."${config.features.impermanence.persistFolder}".neededForBoot =
      true;
    fileSystems."/var/lib/sbctl".neededForBoot = true;

    programs.fuse.userAllowOther = true;

    # Only add system persistance if is enabled
    environment.persistence."${config.features.impermanence.persistFolder}/system" =
      lib.mkIf config.features.persist.enable {
        hideMounts = true;
        directories = lib.attrNames
          (lib.filterAttrs (k: v: v) config.features.persist.directories);
        files = lib.attrNames
          (lib.filterAttrs (k: v: v) config.features.persist.files);
      };

    # Only add home persistance if it is enabled
    environment.persistence."${config.features.impermanence.persistFolder}" =
      lib.mkIf
      config.home-manager.users.${config.spec.user}.features.persist.enable {
        users.${config.spec.user} = {
          directories = lib.attrNames (lib.filterAttrs (k: v: v)
            config.home-manager.users.${config.spec.user}.features.persist.directories);
        };
      };

    # Default persistent directories and files
    features.persist = {
      directories = {
        "/etc/nixos" = true;
        "/var/log" = true;
        "/var/lib/nixos" = true;
        "/var/lib/systemd/coredump" = true;
        "/var/lib/systemd" = true;
        "/var/lib/sbctl" = true;
        "/root" = true;
        "/var/lib/colord" = true;
      };

      files = { "/etc/machine-id" = true; };
    };
  };
}
