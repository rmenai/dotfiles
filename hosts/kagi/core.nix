{ inputs, pkgs, ... }:
let
  secrets = builtins.toString inputs.secrets;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko

    "${inputs.secrets}/nixos.nix"
  ];

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "26.05";

  sops = {
    defaultSopsFile = "${secrets}/hosts/kagi.yaml";
    validateSopsFiles = true;

    gnupg.sshKeyPaths = [ ];

    age = {
      keyFile = "/var/lib/sops/key.txt";
      generateKey = false;
      sshKeyPaths = [ ];
    };
  };

  environment.systemPackages = with pkgs; [
    speedtest-go
    openssl
    wget
    curl
    vim
    git
  ];
}
