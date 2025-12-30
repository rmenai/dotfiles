{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.profiles.core;
in
{
  options.features.profiles.core = {
    enable = lib.mkEnableOption "Core profile";
  };

  config = lib.mkIf cfg.enable {
    features = {
      core = {
        nix.enable = true;
        home.enable = true;
        sops.enable = true;
      };

      users.root.enable = true;
      apps.uutils.enable = true;

      services = {
        tailscale.enable = true;
        openssh.enable = true;
        ssh.enable = true;
      };
    };

    features.core.persistence = {
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/var/lib/colord"
        "/etc/nixos"
        "/root"

        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
        "/var/lib/systemd/network"
      ];
      files = [
        "/etc/machine-id"
      ];
    };

    environment.persistence."${config.features.core.persistence.folder}" = {
      hideMounts = true;
      users.${config.spec.user} = {
        directories = [
          "Downloads"
          "Documents"
          "Pictures"
          "Videos"
          "Public"
          "Games"
          "Music"

          ".ssh"
          ".gnupg"
          ".nixops"

          ".dotfiles"
          ".config"
          ".local"
          ".cache"

          ".ollama"
          ".rustup"
          ".cargo"
          ".opam"
          ".bun"

          ".vagrant.d"
          ".vimgolf"
          ".steam"
        ];
        files = [
          ".bash_history"
          ".adventofcode.session"
        ];
      };
    };

    networking = {
      hostName = config.spec.host;

      firewall = {
        enable = lib.mkDefault true;
        allowPing = lib.mkDefault true;
        trustedInterfaces = [ "tailscale0" ];
        allowedTCPPorts = lib.mkForce [ ];
        allowedUDPPorts = lib.mkForce [ 41641 ]; # Tailscale default
      };
    };

    time.timeZone = lib.mkDefault config.spec.timeZone;
    i18n.defaultLocale = lib.mkDefault config.spec.defaultLocale;

    environment.systemPackages = with pkgs; [
      magic-wormhole-rs
      fastfetch
      curl
      vim
      git
      gh
    ];
  };
}
