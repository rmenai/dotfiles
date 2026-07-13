{ inputs, pkgs, ... }:
let
  secrets = builtins.toString inputs.secrets;
in
{
  imports = [
    # Foundations
    ./filesystem.nix
    ./networking.nix
    ./generated.nix
    ./hardware.nix
    ./scratch.nix
    ./users.nix

    # Hardware
    ./modules/hardware/tlp.nix
    ./modules/hardware/nvidia.nix
    ./../../modules/nixos/hardware/lazaboote.nix
    ./modules/hardware/hibernation.nix
    ./../../modules/nixos/hardware/bluetooth.nix

    # Desktop
    ./modules/desktop/catppuccin.nix
    ./modules/desktop/fcitx5.nix
    ./modules/desktop/fonts.nix
    ./modules/desktop/niri.nix
    ./modules/desktop/sddm.nix

    # System
    ./modules/system/nix.nix
    ./modules/system/cache.nix
    ./../../modules/nixos/system/nix-ld.nix
    ./../../modules/nixos/system/diff.nix
    ./modules/system/libvirt.nix
    ./../../modules/nixos/system/virtualbox.nix
    ./../../modules/nixos/system/printing.nix
    ./modules/system/gaming.nix
    ./modules/system/audio.nix
    ./modules/system/ssh.nix
    # ./modules/system/syncthing.nix
    # ./modules/system/tailscale.nix

    # Apps
    ./modules/apps/obs.nix
    ./../../modules/nixos/apps/adb.nix

    # Inputs
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.catppuccin.nixosModules.catppuccin
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko

    "${inputs.secrets}/nixos.nix"
  ];

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.extraConfig = ''
    Defaults !tty_tickets
    Defaults lecture = never
    Defaults timestamp_timeout=120
  '';

  boot.supportedFilesystems = [ "ntfs" ];
  system.stateVersion = "25.11";

  environment.systemPackages = with pkgs; [
    sops
    age

    magic-wormhole-rs
    fastfetch
    curl
    vim
    git
    zip
    unzip
  ];

  sops = {
    defaultSopsFile = "${secrets}/hosts/null.yaml";
    validateSopsFiles = true;

    gnupg.sshKeyPaths = [ ];

    age = {
      keyFile = "/var/lib/sops/key.txt";
      generateKey = false;
      sshKeyPaths = [ ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.vault = import ../../home/vault/null/default.nix;
  };
}
