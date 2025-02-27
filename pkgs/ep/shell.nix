{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
}:
let
  configuration =
    {
      pkgs,
      lib,
      config,
      modulesPath,
      ...
    }:
    {
      imports = [
        "${modulesPath}/virtualisation/qemu-vm.nix"
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      system.stateVersion = "24.11";
      networking.hostName = "ephemeral-root";
      networking.hostId = "bcdd31f5";

      virtualisation = {
        cores = 4;
        memorySize = 4096;
        graphics = false;

        forwardPorts = [
          {
            from = "host";
            guest.port = 22;
            host.port = 2222;
          }
        ];

        fileSystems."/ephemeral-root" = {
          device = "nixos-config";
          fsType = "9p";
          neededForBoot = true;
          options = [
            "trans=virtio"
            "version=9p2000.L"
            "msize=${toString config.virtualisation.msize}"
          ];
        };
      };

      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "yes";
          PermitEmptyPasswords = "yes";
        };
      };
      # Give root an empty password to ssh in.
      users.users.root = {
        shell = config.programs.fish.package;
        hashedPassword = "";
      };
      security.pam.services.sshd.allowNullPassword = true;
      users.mutableUsers = false;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      #environment.systemPackages = with pkgs; [
      #parted
      #];

      boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      boot.supportedFilesystems = [ "zfs" ];
      systemd.services.zfs-mount.enable = false;

      programs.fish.enable = true;
    };
  machine = import <nixpkgs/nixos> { inherit configuration; };
  start-vm =
    pkgs.writeShellScriptBin "start-vm" # sh
      ''
        EXTRA_DISK=$(mktemp -u -t nixos-XXXXXXX.qcow2)
        ${pkgs.qemu}/bin/qemu-img create -f qcow2 "$EXTRA_DISK" 10G

        export NIX_DISK_IMAGE=$(mktemp -u -t nixos-XXXXXXX.qcow2)

        trap "rm -f $EXTRA_DISK; rm -f $NIX_DISK_IMAGE" EXIT

        export QEMU_OPTS="-virtfs local,path=$PWD,security_model=none,mount_tag=nixos-config -drive id=extra-disk,file=$EXTRA_DISK"

        ${machine.vm}/bin/run-${machine.config.networking.hostName}-vm
      '';
  build =
    pkgs.writeShellScriptBin "build" # sh
      ''
        nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix { }'
      '';
in
pkgs.mkShellNoCC {
  packages = [
    build
    start-vm
  ];
}
